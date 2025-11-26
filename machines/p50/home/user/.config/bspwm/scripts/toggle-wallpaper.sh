#!/bin/sh
#
# Simple toggle wallpaper image

# Background image paths
IMG1="${HOME}/Pictures/walpapers/1.jpg"
IMG2="${HOME}/Pictures/walpapers/2.jpg"

# State file to remember last used image
STATE_FILE="/tmp/${USER}_fehbg_toggle_state"


LAST_USED=2  # Default to 2 so first toggle uses IMG1
# Read previous state
if [ -f "$STATE_FILE" ]; then
  LAST_USED=$(cat "$STATE_FILE")
fi

# Toggle background image
if [ "$LAST_USED" = 1 ]; then
  feh --no-fehbg --bg-fill "$IMG1" "$IMG2"
  echo 2 > "$STATE_FILE"
else
  feh --no-fehbg --bg-fill "$IMG2" "$IMG1"
  echo 1 > "$STATE_FILE"
fi
