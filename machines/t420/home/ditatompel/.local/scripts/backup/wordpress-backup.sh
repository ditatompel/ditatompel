#!/usr/bin/env bash
# To use this script, make sure you can create TCP connection to MySQL server
# from your public IP.

. "${HOME}/.local/scripts/myenv"

BACKUP_RETENTION_LOCAL=3 # in days
VPN_GW_IP="10.88.88.1"

print_prog_desc()
{
  echo "Backup my 'friends' WP sites from remote server, store to local machine"
  echo "and optionally create archive copy to S3."
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

ARCHIVE_BACKUP=false

while getopts ":ha" option; do
  case $option in
    a) # create archive and upload to S3
      ARCHIVE_BACKUP=true
      ;;
    h) # display Help
      print_prog_desc
      print_help
      exit;;
    \?) # Invalid option
      echo "Invalid option!"
      print_help
      exit;;
  esac
done

# Check connection if computer connected to VPN
echo "Checking connection..."
ping -c 1 -W 4 ${VPN_GW_IP} > /dev/null

[ $? -ne 0 ] && echo "Can't ping VPN gateway. Exiting..." && exit 1
echo "Connection OK!"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Running script from ${SCRIPT_DIR}"

for WEBSITE in "${WP_SITES[@]}"
do
  BACKUPDATE=$(date +%Y-%m-%d-%H-%M)
  IFS='|' read -ra WEBPARAMS <<< "${WEBSITE}"
  echo
  echo "Backing up web dir to ${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}"
  mkdir -p "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}"
  rsync --exclude DATABASE --exclude .git -avh \
    root@"${WP_SERVER_IP}":"${WEBPARAMS[1]}/"  \
    "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/"  \
    --delete-after --progress

  echo
  echo "Backing up DB to ${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE"
  mkdir -p "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE"

  mariadb-dump "${WEBPARAMS[2]}"     \
    -h "${WP_SERVER_IP}"             \
    -u "${MASTER_REMOTE_MYSQL_USER}" \
    -p"${MASTER_REMOTE_MYSQL_PASS}"  \
    --single-transaction             \
    | gzip > "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE/${BACKUPDATE}-${WEBPARAMS[2]}.sql.gz"

  # Remove old backup
  echo
  echo "Removing old backups..."
  find "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE/" \
    -type f -name "*.sql.gz" -mtime +${BACKUP_RETENTION_LOCAL} -delete

  # Mirror SQL to S3
  echo
  echo "Mirroring to S3 server(s)..."
  mcli mirror \
    "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE" \
    "ctb1/backups/wordpress/${WEBPARAMS[0]}/DATABASE" \
    --remove -a --overwrite
  mcli mirror \
    "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}/DATABASE" \
    "smg1/backups/wordpress/${WEBPARAMS[0]}/DATABASE" \
    --remove -a --overwrite

  # Compress and copy backup to remote location (just in case)
  [ "${ARCHIVE_BACKUP}" = false ] && continue
  cd "${WP_DEST_BACKUP_PATH}/${WEBPARAMS[0]}" || continue
  echo
  echo "Creating tar.gz archive..."
  tar -cjf public_html.tar.gz public_html
  echo
  echo "Uploading archived backup to S3..."
  mcli cp \
    public_html.tar.gz \
    "ctb1/backups/wordpress/${WEBPARAMS[0]}/public_html.tar.gz"
  mcli cp \
    public_html.tar.gz \
    "smg1/backups/wordpress/${WEBPARAMS[0]}/public_html.tar.gz"
  rm public_html.tar.gz

  cd "${SCRIPT_DIR}" || continue
done

# vim: set ts=2 sw=2 et:
