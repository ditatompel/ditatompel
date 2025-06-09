#!/usr/bin/env bash
#
# Emulate a dropdown terminal
# This script adapted from https://wiki.archlinux.org/title/Bspwm#Using_pid

app="${1}"
lockf="/tmp/scratch_${1}.pid"

bspc_write_nodeid() {
  while true
  do
    flag=false
    for id in $(bspc query -d focused -N -n .floating.sticky.hidden)
    do
      bspc query --node "${id}" -T \
        | grep -q "${app}" && { echo "${id}" > "${lockf}"; flag=true; break; }
    done
    [[ "$flag" == "true" ]] && break
    sleep 0.1s
  done
}

hide_all_except_current(){
  for id in $(bspc query -d focused -N -n .floating.sticky.!hidden)
  do
    bspc query --node "${id}" -T \
      | grep -qvE "(${app}|showmethekey-gtk)" \
      && bspc node "${id}" --flag hidden=on
  done
}

toggle_hidden() {
  [ -e "${lockf}" ] || exit 1
  hide_all_except_current
  id=$(<"${lockf}")
  bspc node "${id}" --flag hidden -f
}

create_terminal() {
  alacritty --class="${app}","${app}" -e "${1}" &
}

pgrep -f "class=${app}" > /dev/null && {
  toggle_hidden
  exit 0
}

bspc rule -a "${app}" --one-shot state=floating sticky=on hidden=on
case "${app}" in
  "term")
    create_terminal "${SHELL}"
    ;;
  "fm")
    create_terminal yazi
    ;;
  "mail")
    create_terminal neomutt
    ;;
  *)
    exit 1
esac

bspc_write_nodeid
toggle_hidden

# If you want to show notification when new scracthpad emulated, do it here.
# E.g with dunstify:
dunstify "Scratch: starting ${app}"

# vim: set sw=2 ts=2 et
