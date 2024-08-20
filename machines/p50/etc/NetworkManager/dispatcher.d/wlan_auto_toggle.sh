#!/bin/sh
#
# Automatically toggle wireless depending on LAN cable being plugged in.
#
# Note that there is a fail-safe for the case when the LAN interface was
# connected when the computer was last on, and then disconnected while
# the computer was off. That would mean the radio would still be off when
# the computer is turned back on, and with a disconnected LAN interface,
# you would have no network. 
# See: https://wiki.archlinux.org/title/NetworkManager#Network_services_with_NetworkManager_dispatcher

# You can get a list of interfaces using nmcli.
# The Ethernet (LAN) interfaces usually start with `en`. E.g. `enp0s...`
if [ "${1}" = "enp0s31f6" ]; then
  case "${2}" in
    up)
      nmcli radio wifi off
      ;;
    down)
      nmcli radio wifi on
      ;;
  esac
elif [ "$(nmcli -g GENERAL.STATE device show enp0s31f6)" = "20 (unavailable)" ]; then
  nmcli radio wifi on
fi

# vim: set ts=2 sw=2 et:
