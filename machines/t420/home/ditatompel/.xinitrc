#!/bin/sh

#userresources=$HOME/.Xresources
userresources=$HOME/.config/X11/xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard rate speed and delay 
xset r rate 250 30 &

# disable monitor sleep when no activity
xset -dpms
xset s off

# Swap escape and capslock
# setxkbmap -option caps:swapescape

# Bind key volume Lenovo T420
xbindkeys

#eval $(gnome-keyring-daemon --start)
#export SSH_AUTH_SOCK
eval $(ssh-agent)

#exec openbox-session
exec bspwm
