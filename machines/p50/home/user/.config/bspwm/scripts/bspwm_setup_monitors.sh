#!/usr/bin/env bash
## bspwm dual monitor config
## Based on miikanissi's config: https://github.com/miikanissi/dotfiles
## For more detailed information, read:
## https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/

RANDR=$(xrandr)

INTERN=$(echo "$RANDR" | awk '/ primary/{print $1}')
EXTERN=$(echo "$RANDR" | awk '/ connected/{print $1}' | grep -v "$INTERN")

monitor_add() {
  # Move last 5 desktops to external monitor
  for desktop in {6..12}
  do
    bspc desktop "$desktop" --to-monitor "$EXTERN"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # reorder monitors
  bspc wm -O "$INTERN" "$EXTERN"
}

monitor_remove() {
  # Add temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$EXTERN" -a Desktop

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$EXTERN");
  do
      bspc desktop "$desktop" --to-monitor "$INTERN"
  done

  # delete default desktops
  bspc desktop Desktop --remove
  # reorder desktops
  bspc monitor "$INTERN" -o {1..14}
}

if [[ ! -z "$EXTERN" ]]; then # external monitor connected
  # set xrandr rules for docked setup
  xrandr \
    --output "$INTERN" --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output "$EXTERN" --mode 2560x1440 --pos 1920x0 --rotate normal

  if [[ $(bspc query -D -m "${EXTERN}" | wc -l) -ne 6 ]]; then
    monitor_add
  fi
  bspc wm -O "$INTERN" "$EXTERN"
else
  # set xrandr rules for mobile setup
  xrandr \
    --output "$INTERN" --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output "$EXTERN" --off
  if [[ $(bspc query -D -m "${INTERN}" | wc -l) -ne 12 ]]; then
    monitor_remove
  fi
fi

## Wallpaper
## If you want to use wallpaper, execute your wallpaper command here.
## Note that using no background may generate warning log:
## "background_manager: Failed to get root pixmap, default to black
## (is there a wallpaper?)" even you set polybar pseudo-transparency = false.
feh --no-fehbg --bg-fill \
  "${HOME}/Pictures/walpapers/1.jpg" \
  "${HOME}/Pictures/walpapers/2.jpg"

# Kill and relaunch polybar
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if [[ $(xrandr -q | grep -e "^${EXTERN} connected") ]]; then
  polybar --reload primary -c ~/.config/polybar/config.ini \
    </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
  polybar --reload secondary -c ~/.config/polybar/config.ini \
    </dev/null >/var/tmp/polybar-secondary.log 2>&1 200>&- &
else
  polybar --reload single -c ~/.config/polybar/config.ini \
    </dev/null >/var/tmp/polybar-single.log 2>&1 200>&- &
fi

# vim: set ts=2 sw=2 et:
