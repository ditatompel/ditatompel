# My Personal dotfiles

This is my personal config file. This dotfiles repo is not intended to "rice" your desktop. This repo is far from complete, I'll update this repo during my spare time.

## Packages
* [sxhkd](https://wiki.archlinux.org/title/Sxhkd)
* [lm_sensors](https://wiki.archlinux.org/title/Lm_sensors) for `polybar` fan speed indicator.
* vim
* vim-airline
* vim-plug
* zsh
* oh-my-zsh
* [PCManFM](https://wiki.archlinux.org/title/PCManFM)
* [dunst](https://wiki.archlinux.org/title/Dunst)
* [flameshot](https://wiki.archlinux.org/title/Flameshot) for default screenshot app.

### Required command-line utilities
* bc
* jq
* [imagemagick](https://archlinux.org/packages/?name=imagemagick) for alternate screenshot. Probably you already have `imagemagick` installed on your system. See [~/.local/scripts/system/screenshot.sh](.local/scripts/system/screenshot.sh). For more information about screenshot options.


## Hardware Topology
```
lstopo -.ascii
┌────────────────────────────────────────────────────────────────────────────────┐
│ Machine (16GB total)                                                           │
│                                                                                │
│ ┌────────────────────────────────┐  ├┤╶─┬─────┬─────────────┐                  │
│ │ Package L#0                    │      │     │ PCI 00:02.0 │                  │
│ │                                │      │     └─────────────┘                  │
│ │ ┌────────────────────────────┐ │      │                                      │
│ │ │ NUMANode L#0 P#0 (16GB)    │ │      ├─────┬─────────────────┐              │
│ │ └────────────────────────────┘ │      │     │ PCI 00:19.0     │              │
│ │                                │      │     │                 │              │
│ │ ┌────────────────────────────┐ │      │     │ ┌─────────────┐ │              │
│ │ │ L3 (4096KB)                │ │      │     │ │ Net enp0s25 │ │              │
│ │ └────────────────────────────┘ │      │     │ └─────────────┘ │              │
│ │                                │      │     └─────────────────┘              │
│ │ ┌────────────┐  ┌────────────┐ │      │                                      │
│ │ │ L2 (256KB) │  │ L2 (256KB) │ │      ├─────┼┤╶───────┬────────────────┐     │
│ │ └────────────┘  └────────────┘ │      │0.2       0.2  │ PCI 03:00.0    │     │
│ │                                │      │               │                │     │
│ │ ┌────────────┐  ┌────────────┐ │      │               │ ┌────────────┐ │     │
│ │ │ L1d (32KB) │  │ L1d (32KB) │ │      │               │ │ Net wlp3s0 │ │     │
│ │ └────────────┘  └────────────┘ │      │               │ └────────────┘ │     │
│ │                                │      │               └────────────────┘     │
│ │ ┌────────────┐  ┌────────────┐ │      │                                      │
│ │ │ L1i (32KB) │  │ L1i (32KB) │ │      └─────┬──────────────────────────────┐ │
│ │ └────────────┘  └────────────┘ │            │ PCI 00:1f.2                  │ │
│ │                                │            │                              │ │
│ │ ┌────────────┐  ┌────────────┐ │            │ ┌───────────┐  ┌───────────┐ │ │
│ │ │ Core L#0   │  │ Core L#1   │ │            │ │ Block sdb │  │ Block sdc │ │ │
│ │ │            │  │            │ │            │ │           │  │           │ │ │
│ │ │ ┌────────┐ │  │ ┌────────┐ │ │            │ │ 931 GB    │  │ 476 GB    │ │ │
│ │ │ │ PU L#0 │ │  │ │ PU L#2 │ │ │            │ └───────────┘  └───────────┘ │ │
│ │ │ │        │ │  │ │        │ │ │            │                              │ │
│ │ │ │  P#0   │ │  │ │  P#2   │ │ │            │ ┌───────────┐                │ │
│ │ │ └────────┘ │  │ └────────┘ │ │            │ │ Block sda │                │ │
│ │ │ ┌────────┐ │  │ ┌────────┐ │ │            │ │           │                │ │
│ │ │ │ PU L#1 │ │  │ │ PU L#3 │ │ │            │ │ 465 GB    │                │ │
│ │ │ │        │ │  │ │        │ │ │            │ └───────────┘                │ │
│ │ │ │  P#1   │ │  │ │  P#3   │ │ │            └──────────────────────────────┘ │
│ │ │ └────────┘ │  │ └────────┘ │ │                                             │
│ │ └────────────┘  └────────────┘ │                                             │
│ └────────────────────────────────┘                                             │
└────────────────────────────────────────────────────────────────────────────────┘
┌────────────────────────────────────────────────────────────────────────────────┐
│ Host: t420                                                                     │
└────────────────────────────────────────────────────────────────────────────────┘
```
