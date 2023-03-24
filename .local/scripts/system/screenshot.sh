#!/bin/bash
## https://github.com/ditatompel/dotfiles

# I use `flameshot` for my default screnshot app.
flameshot gui
exit 0

# Below is to create screenshot with `imagemagick` and notify using `dunstify`.
# Using this method will take screenshot the whole monitor display.
# Uncomment `flameshot gui`` command above and `exit code 0`` to use this.
source $HOME/.local/scripts/myenv

if [ ! -d "$SCREENSHOT_BASE_DIR/$SCREENSHOT_DATE_FOLDER" ]; then
    mkdir -p "$SCREENSHOT_BASE_DIR/$SCREENSHOT_DATE_FOLDER"
fi

import -window root "$SCREENSHOT_BASE_DIR/$SCREENSHOT_DATE_FOLDER/$(date '+%Y-%m-%d_%H%M%S')_$(hostname).jpg"

# Below need dunst to work.
# uncomment if you did not have dunst installed.
NOTIF_ACTION=$(dunstify --action="default,Reply" --action="forwardAction,Forward" "Screenshot saved.")

case "$NOTIF_ACTION" in
"default")
    # do default action (center mouse click)
    # pass to your fav file manager
    pcmanfm -n "$SCREENSHOT_BASE_DIR/$SCREENSHOT_DATE_FOLDER"
    ;;
"forwardAction")
    # do forward action
    ;;
"2")
    # do default dismiss
    ;;
esac