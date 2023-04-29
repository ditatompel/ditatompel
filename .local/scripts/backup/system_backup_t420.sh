#!/bin/bash
#title           : system_backup_t420.sh
#description     : Simple command to backup /etc, /srv, and my home dir.
#author          : Christian Ditaputratama <svcadm@ditatompel.com>
#date            : 2020-12-07
#last update     : 2022-07-16
#version         : 0.0.4
#usage           : ./system_backup_t420.sh
#notes           : This is NOT incremental backup and make sure destination
#                : backup dir is mounted.
#==============================================================================

# Home user dir to backup
TARGET_HOME_DIR="/home/ditatompel"

# Destination backup dir. Recommended to separated drive or mounted network drive.
BACKUP_DIR='/mnt/hdd2/BACKUPS/SYSBACKUP/T420'

# end of basic configuration
div=======================================

# Check if script running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Absolute path where script is located and executed
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Import pre-defined variable from myenv
cd $SCRIPT_DIR
cd ..
source myenv

# Lockfile
LOCKFILE="/var/lock/mysystembackup.lck"
exec 9>"${LOCKFILE}"
flock -n 9 || exit

cd $BACKUP_DIR

# List of installed package
# to restore, use pacman -S --needed - < pkglist.txt
pacman -Qqe > "$BACKUP_DIR/pkglist.txt"

rsync -avh "$TARGET_HOME_DIR/" "$BACKUP_DIR$TARGET_HOME_DIR/" \
    --exclude=".cache"              \
    --exclude=".mozilla"            \
    --exclude=".thumbnails"         \
    --exclude=".thunderbird"        \
    --exclude=".local/share/winbox" \
    --exclude=".winbox"             \
    --exclude=".nvm"                \
    --exclude=".npm"                \
    --exclude=".rvm"                \
    --exclude=".gradle"             \
    --exclude=".rustup"             \
    --exclude="go"                  \
    -P                              \
    --delete-after

rsync -avh "/etc" "$BACKUP_DIR/" -P --delete-after

# Web Dev Files
rsync -avh "/srv" "$BACKUP_DIR/" -P --delete-after

# RAW SQL
#rsync -avh "/var/lib/mysql/" "$BACKUP_DIR/var/lib/mysql/" --progress -delete-after

# DUMP mysql
ISMYSQLUP=$(pgrep mariadb | wc -l);
if [ "$ISMYSQLUP" -ne 1 ]; then
    echo "MySQL process not running! Skip dumping MySQL database..."
else
    echo "Backing up MySQL..."
    for DB in $(mysql -e 'show databases' -s --skip-column-names); do
        if [[ ! $DB =~ _schema$ ]]; then
            echo "Dump database $DB..."
            mysqldump $DB -h $LOCAL_MYSQL_HOST -u $LOCAL_MYSQL_USER -p$LOCAL_MYSQL_PASS > "$BACKUP_DIR/DATABASE/dump/$DB.sql";
        fi
    done
fi

