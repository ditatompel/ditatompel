#!/usr/bin/env bash
## Dual Monitor Auto Detect
## Based on miikanissi config.
## https://github.com/miikanissi/dotfiles
## Please read https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/
## and https://github.com/miikanissi/dotfiles/blob/master/.local/bin/bspwm_setup_monitors.sh
## for more information.

XRANDR_OUTPUT=$(xrandr)

INTERNAL_MONITOR=$(echo "$XRANDR_OUTPUT" | awk '/ primary/{print $1}')
EXTERNAL_MONITOR=$(echo "$XRANDR_OUTPUT" | awk '/ connected/{print $1}' | grep -v "$INTERNAL_MONITOR")

INTERNAL_MONITOR_RESOLUTION=$(echo "$XRANDR_OUTPUT" | awk '/'"$INTERNAL_MONITOR"'.*primary/{getline; print $1}')
EXTERNAL_MONITOR_RESOLUTION=$(echo "$XRANDR_OUTPUT" | awk '/'"$EXTERNAL_MONITOR"'.*connected/{getline; print $1}')

monitor_add() {
  # Move first 5 desktops to external monitor
  #for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 5q); do
  #  bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
  #done

  for desktop in {6..10}
  do
    bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # reorder monitors
  bspc wm -O "$INTERNAL_MONITOR" "$EXTERNAL_MONITOR"
}

monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$EXTERNAL_MONITOR" -a Desktop

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$EXTERNAL_MONITOR");
  do
      bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  # delete default desktops
  bspc desktop Desktop --remove
  # reorder desktops
  #bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
  bspc monitor "$INTERNAL_MONITOR" -o {1..12}
}

if [[ ! -z "$EXTERNAL_MONITOR" ]]; then # external monitor connected
  # set xrandr rules for docked setup
  xrandr --output "$INTERNAL_MONITOR" --primary --mode 1600x900 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --mode 1280x1024 --pos 1600x0 --rotate normal
  if [[ $(bspc query -D -m "${EXTERNAL_MONITOR}" | wc -l) -ne 5 ]]; then
    monitor_add
  fi
  bspc wm -O "$INTERNAL_MONITOR" "$EXTERNAL_MONITOR"
else
  # set xrandr rules for mobile setup
  xrandr --output "$INTERNAL_MONITOR" --primary --mode 1600x900 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --off
  if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
    monitor_remove
  fi
fi

## Wallpaper
## If you want to use wallpaper, execute your wallpaper command here.
## For now, I just want to "use" blank black color with no pict.
#nitrogen --restore &
#feh --no-fehbg --bg-fill '/path/to/wallpaper/pict1.jpg' '/path/to/wallpaper/pict2.jpg'

# Kill and relaunch polybar
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done

if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  polybar --reload primary -c ~/.config/polybar/bspwm-config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
  polybar --reload secondary -c ~/.config/polybar/bspwm-config.ini </dev/null >/var/tmp/polybar-secondary.log 2>&1 200>&- &
else
  polybar --reload primary -c ~/.config/polybar/bspwm-config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
fi
