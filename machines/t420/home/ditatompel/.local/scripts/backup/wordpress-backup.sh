#!/bin/bash
# To use this script, make sure you can connect to server SSH
# and MySQL from your public IP.
# Add more docs latter

source $HOME/.local/scripts/myenv

BACKUP_RETENTION_LOCAL=3
VPN_GW_IP="10.88.88.1"

print_prog_desc()
{
   echo "Backup my WP sites from remote server, store to local"
   echo "machine and optionally create archive copy to S3."
   echo
}

print_help()
{
   echo "Syntax: ${0} [-a|-h]"
   echo "options:"
   echo "-a     Create archived backup and upload to S3."
   echo "-h     Print this Help."
   echo
}

DO_ARCHIVE_BACKUP=false

while getopts ":ha" option; do
    case $option in
        h) # display Help
            print_prog_desc
            print_help
            exit;;
        a) # create archive and upload to S3
            DO_ARCHIVE_BACKUP=true
            ;;
        \?) # Invalid option
            echo "Invalid option!"
            print_help
            exit;;
    esac
done

# Check connection if computer connected to VPN
echo "Checking connection..."
ping -c 1 -W 10 ${VPN_GW_IP} > /dev/null
if [ $? -ne 0 ]; then
    echo "Can't ping VPN gateway. Exiting..."
    exit 1
fi
echo "Connection OK!"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

BLOCK=$(printf "%32s")

echo "Running script from ${SCRIPT_DIR}"

echo ${BLOCK// /\#}

for WEBSITE in "${WORDPRESS_WEBSITES[@]}"
do
    BACKUPDATE=`date +%Y-%m-%d-%H-%M`
    IFS='|' read -ra WEBPARAMS <<< "$WEBSITE"
    echo "Backing up web directory from remote server to ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}"
    mkdir -p ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}
    rsync -e "ssh -i $MASTER_SSH_PRIVATE_KEY_PATH" --exclude DATABASE --exclude .git -avh root@$WORDPRESS_SERVER_IP:${WEBPARAMS[1]}/ ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/ --delete-after --progress
    
    echo "Backing up sql database from remote server to ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE"
    mkdir -p ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE
    
    echo ${WEBPARAMS[4]}
    mysqldump ${WEBPARAMS[2]} -h $WORDPRESS_SERVER_IP -u ${MASTER_REMOTE_MYSQL_USER} -p${MASTER_REMOTE_MYSQL_PASS} --single-transaction | gzip > "${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE/${BACKUPDATE}-${WEBPARAMS[2]}.sql.gz";

    # Remove old backup
    find ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE/ -type f -name "*.sql.gz" -mtime +${BACKUP_RETENTION_LOCAL} -delete
    # Mirror SQL to S3
    mcli mirror ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE ctb1/backups/wordpress/${WEBPARAMS[0]}/DATABASE --remove -a --overwrite
    mcli mirror ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE smg1/backups/wordpress/${WEBPARAMS[0]}/DATABASE --remove -a --overwrite

    # Compress and copy backup to remote location (just in case)
    if [ "${DO_ARCHIVE_BACKUP}" = true ]; then
        cd ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}
        tar -cjf public_html.tar.gz public_html
        mcli cp public_html.tar.gz ctb1/backups/wordpress/${WEBPARAMS[0]}/public_html.tar.gz
        mcli cp public_html.tar.gz smg1/backups/wordpress/${WEBPARAMS[0]}/public_html.tar.gz
        rm public_html.tar.gz
        mcli mirror ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE ctb1/backups/wordpress/${WEBPARAMS[0]}/DATABASE --remove -a --overwrite
        mcli mirror ${WORDPRESS_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE smg1/backups/wordpress/${WEBPARAMS[0]}/DATABASE --remove -a --overwrite
        cd ${SCRIPT_DIR}
    fi
done

