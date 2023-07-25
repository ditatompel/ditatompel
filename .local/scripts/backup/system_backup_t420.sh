#!/bin/sh
#title           : system_backup_t420.sh
#description     : Simple command to backup /etc, /srv, and my home dir.
#author          : Christian Ditaputratama <svcadm@ditatompel.com>
#version         : 0.0.5
#usage           : ./system_backup_t420.sh
#notes           :
# This is NOT incremental backup and make sure
# destination backup dir is mounted.
#==============================================================================

# Home user dir to backup
TARGET_HOME_DIR="/home/ditatompel"

# Destination backup dir. Recommended to separated drive or mounted network drive.
BACKUP_DIR='/mnt/hdd2/BACKUPS/SYSBACKUP/T420'

# end of basic configuration
div=======================================

# Check if script running as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

# Lockfile
LOCKFILE="/var/lock/mysystembackup.lck"
exec 9>"${LOCKFILE}"
flock -n 9 || exit

# List of installed package
# to restore, use pacman -S --needed - < pkglist.txt
pacman -Qqe > "${BACKUP_DIR}/pkglist.txt"

rsync -avh "${TARGET_HOME_DIR}/" "${BACKUP_DIR}${TARGET_HOME_DIR}/" \
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

rsync -avh "/etc" "${BACKUP_DIR}/" -P --delete-after

# Web Dev Files
rsync -avh "/srv" "${BACKUP_DIR}/" -P --delete-after

# DUMP MySQL / MariaDB
ISMARIADBUP=$(pgrep mariadb | wc -l);
if [ "${ISMARIADBUP}" -ne 1 ]; then
    echo "MariaDB process not running! Skip dumping MariaDB database..."
else
    echo "Backing up MariaDB..."
    
    for DB in $(mariadb -e 'show databases' -s --skip-column-names); do
      case "${DB}" in
        *_schema)
          continue ;;
        *)
          echo "Dump database ${DB}..."
          mariadb-dump ${DB} > "${BACKUP_DIR}/DATABASE/dump/${DB}.sql" ;;
      esac
  done

fi
