#!/usr/bin/env bash
#
# Read sxhkd config and display keybinds information using rofi.
# This shell script was originally taken from EndeavourOS bspwm edition.

set -e

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' \
  ~/.config/sxhkd/sxhkdrc \
  | column -t -s $'\t' \
  | rofi -dmenu -i -p "keybindings:" -markup-rows -no-show-icons \
    -theme-str 'listview { columns: 1;}'

# vim: set ts=2 sw=2 et:
