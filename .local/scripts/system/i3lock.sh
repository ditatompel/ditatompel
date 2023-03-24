#!/bin/sh
# I use AUR [i3lock-color](https://aur.archlinux.org/packages/i3lock-color)
# package for this.

RED='#ff1f57'
BLUE='#1fc3ff'
GREEN='#1fffce'
RINGCOLOR='#70AECD'
GREETERTXT="Type password to unlock!"

i3lock                       \
--screen 1                   \
--blur 5                     \
--clock                      \
--indicator                  \
--ring-color=$RINGCOLOR      \
--time-str="%H:%M:%S"        \
--time-color=$BLUE           \
--date-str="%A, %m %Y"       \
--date-color=$GREEN          \
--verif-text="Verifying.."   \
--verif-color=$BLUE          \
--wrong-text="Nope!"         \
--greeter-color=$RINGCOLOR   \
--greeter-text="$GREETERTXT"
