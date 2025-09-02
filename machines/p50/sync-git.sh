#!/bin/sh
# Sync changed files to repo
# MUST be executed from current script directory

set -e 

WORKING_DIR="${HOME}/.local/src/dt/dit/machines/p50"

rsync / "${WORKING_DIR}/" --include-from "${WORKING_DIR}/rsync-include" -avh

# Packages
mkdir -p "${WORKING_DIR}/PKGS"
# List of explicity installed packages
# to restore, use `pacman -S --needed - < pkglist.txt`
# Note that the restore command above will fail if you have package(s)
# installed from AUR.
pacman -Qqe > "${WORKING_DIR}/PKGS/pacman-Qqe.txt"

# List of explicity installed packages from AUR
pacman -Qqme > "${WORKING_DIR}/PKGS/pacman-Qqme.txt"
