# T420 Config

> **NOTE**: This machine is **DEAD**, RIP! Everything under this directory will not be updated again!

This is my personal laptop config file. The configurations under this directory is not intended to "rice" your desktop. Maybe this dotfiles repo is one of most boring desktop you ever see, trust me! No compositor, no transparency, no animation, nothing. Just basic BSPWM with polybar plus my most used app config.

I put my configs and scripts here for my self, to make me easier moving my machine to the new one if something bad happen to my beloved laptop. But, if you find it useful for you, just clone and edit to fit with your need.

This repo is far from complete, I'll update this repo during my spare time.

## Packages

### Required command-line utilities

- `rsync`: Most of my backup scripts use rsync. [rsync.samba.org](https://rsync.samba.org/) | [rsync Arch Wiki](https://wiki.archlinux.org/title/Rsync).
- `rclone` for some remote and _"encrypted"_ backup. [rclone.org](https://rclone.org/).
- `bc` for arbitrary precision numeric processing. [GNU bc](https://www.gnu.org/software/bc/).
- `jq` for command-line JSON processor. [github.com/jqlang/jq](https://github.com/jqlang/jq).
- [imagemagick](https://archlinux.org/packages/?name=imagemagick) for alternate screenshot. [ImageMagick Arch Wiki](https://wiki.archlinux.org/title/ImageMagick). Probably you already have `imagemagick` installed on your system. See [./home/ditatompel/.local/scripts/system/screenshot.sh](./home/ditatompel/.local/scripts/system/screenshot.sh). For more information about screenshot options.
- `lm_sensors` used to detect fan for `polybar` fan speed indicator script. [lm_sensors Arch Wiki](https://wiki.archlinux.org/title/Lm_sensors).

### Display

- **XOrg** (`xorg-server`, `xorg-xsetroot`, `xorg-xrandr`). [Xorg Arch Wiki](https://wiki.archlinux.org/title/Xorg).
- `bspwm` + `sxhkd`. [bspwm Arch Wiki](https://wiki.archlinux.org/title/Bspwm) | [Sxhkd Arch Wiki](https://wiki.archlinux.org/title/Sxhkd).
- `feh` Image viewer and background setter. [feh.finalrewind.org](https://feh.finalrewind.org/) | [feth Arch Wiki](https://wiki.archlinux.org/title/Feh).
- `pcmanfm` GUI file manager. [PCManFM Arch Wki](https://wiki.archlinux.org/title/PCManFM).
- `dunst` notification daemon. [dunst-project.org](https://dunst-project.org/) | [Dunst](https://wiki.archlinux.org/title/Dunst)
- `flameshot` for default screenshot app. [flameshot.org](https://flameshot.org/) | [Flameshot Arch Wiki](https://wiki.archlinux.org/title/Flameshot).

### Shell & Terminal

- `zsh` default shell (vanilla). [zsh.org](https://www.zsh.org/) | [Zsh Arch Wiki](https://wiki.archlinux.org/title/Zsh).
- `alacritty` as default terminal. [github.com/alacritty/alacritty](https://github.com/alacritty/alacritty) | [Arch Wiki](https://wiki.archlinux.org/title/Alacritty).
- `rxvt-unicode` + `urxvt-perls` extension for alternative legacy terminal. [rxvt-unicode Arch Wiki](https://wiki.archlinux.org/title/Rxvt-unicode).
- `tmux` terminal miltiplexer. [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki) | [tmux Arch Wiki](https://wiki.archlinux.org/title/Tmux).

### Editors

- `vim` with `vim-airline` and `vim-plug` plugins. [vim.org](https://www.vim.org/) | [Vim Arch Wiki](https://wiki.archlinux.org/title/Vim).
- `nvim` for coding session (using [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)). [neovim.io](https://neovim.io/) | [NeoVim Arch Wiki](https://wiki.archlinux.org/title/Neovim).

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
