#!/bin/sh
# Change brightness of the screen backlight using ACPI kernel module
#
# By default, only root can change the brightness by this method.
# To allow users in the video group to change the brightness, an aditional
# udev rule can be used.
# See: https://wiki.archlinux.org/title/Backlight#ACPI

# find your ACPI kernel module interface using `ls /sys/class/backlight`
iface="/sys/class/backlight/intel_backlight"
step=5

set -e

max=$(cat "$iface/max_brightness")
actual=$(cat "$iface/actual_brightness")
control="$iface/brightness"

steps=$((max * step / 100))

if [ "$1" = "down" ]; then
  down=$((actual - steps))
  [ $down  -lt 1 ] &&  echo "0" > "$control" && exit 0
  echo "$down" > "$control" && exit 0
fi

up=$((actual + steps))
[ $up -gt $((max + 0)) ] && echo "$max" > "$control" && exit 0
echo "$up" > "$control"
