#!/bin/bash
#
# Screen capcure using `flameshot` or `import` commanf from `imagemagick`.
# NOTE: If using imagemagick, `dunst` package is required for notification.

# In this machine, I use `flameshot` for my default screnshot app.
flameshot gui
exit 0

# Below is to create screenshot with `imagemagick` and notify using `dunstify`.
# Using this method will take screenshot the whole monitor display.
# Uncomment `flameshot gui`` command above and `exit code 0`` to use this.
SS_DIR="${HOME}/Pictures/albums/ss/$(date '+%Y')/$(date '+%m')"

if [ ! -d "${SS_DIR}" ]; then
  mkdir -p "${SS_DIR}"
fi

import -window root "${SS_DIR}/$(date '+%Y-%m-%d_%H%M%S')_$(hostnamectl hostname).jpg"

# Below need dunst to work.
# uncomment if you did not have dunst installed.
NOTIF=$(dunstify --action="default,Reply" --action="forwardAction,Forward" "Screenshot saved.")

case "${NOTIF}" in
  "default")
    # do default action (mouse middle click)
    # pass to file manager
    pcmanfm -n "${SS_DIR}"
    ;;
  "forwardAction")
    # do forward action
    ;;
  "2")
    # do default dismiss
    ;;
esac

# vim: ts=2 sw=2 et
