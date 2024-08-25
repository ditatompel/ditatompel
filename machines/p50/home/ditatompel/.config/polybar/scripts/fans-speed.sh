#!/bin/sh
#
# Get fan speed information from `sensors` command.
#
# This script require `lm_sensors` to be configured properly.
# Read https://wiki.archlinux.org/title/Lm_sensors

set -e

# The example output of `sensors` command is something like this:
#   ...
#   thinkpad-isa-0000
#   Adapter: ISA adapter
#   fan1:        2300 RPM
#   fan2:        2100 RPM
#   CPU:          +40.0°C
#   ...
# The command below only print specific chip, that is: `thinkpad-isa-0000`.
# If you only have 1 fan on your machine, simply use:
# sensors thinkpad-isa-0000 | grep fan1 | awk '{print $2}'
sensors thinkpad-isa-0000 | grep fan | awk '{printf "%s%s", $2, (NR==2 ? "" : " | ")}'

# vim: set ts=2 sw=2 et
