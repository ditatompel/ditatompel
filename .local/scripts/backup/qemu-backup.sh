#!/bin/bash
#title           : qemu-backup-t420.sh
#description     : Simple command to backup QEMU images in my T420.
#author          : Christian Ditaputratama <svcadm@ditatompel.com>
#date            : 2020-12-07
#last update     : 2022-07-16
#version         : 0.0.4
#usage           : ./qemu-backup-t420.sh
#notes           :
# This is NOT incremental backup, using zstd instead of gzip compression.
# Do not run this script as root and make sure source QEMU image files
# (`${QEMU_IMAGE_PATH}`) are readable and destination local path
# (`${LOCAL_QEMU_BACKUP_PATH}`) is writable by the user who run this script.
# For remote destination (`${REMOTE_QEMU_BACKUP_PATH`), I use rclone to copy
# image files from `${LOCAL_QEMU_BACKUP_PATH}` to `${REMOTE_QEMU_BACKUP_PATH}`. 
#==============================================================================

QEMU_IMAGE_PATH="/mnt/msata/.VMs"
LOCAL_QEMU_BACKUP_PATH="/mnt/hdd2/BACKUPS/VMs"
REMOTE_QEMU_BACKUP_PATH="crypt:/BACKUPS/VMs"

# end of basic configuration
div=======================================

# Check if script running as root
if [[ $EUID -eq 0 ]]; then
   echo "Do not run this script as root"
   exit 1
fi

# Lockfile
LOCKFILE="/tmp/myqemubackup.lock"
exec 9>"${LOCKFILE}"
flock -n 9 || exit

cd ${QEMU_IMAGE_PATH}
for qcow in *;
do
   tar -I 'zstd -9 -v --sparse' -Scvf ${LOCAL_QEMU_BACKUP_PATH}/${qcow}.tar.zst ${qcow};
   rclone copy ${LOCAL_QEMU_BACKUP_PATH}/${qcow}.tar.zst ${REMOTE_QEMU_BACKUP_PATH}/ -P
done
