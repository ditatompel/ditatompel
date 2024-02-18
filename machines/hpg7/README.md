# HPG7 Config

This is my other laptop config file. The configurations under this directory is not intended to "rice" your desktop (mostly similar with the `T420` config. No compositor, no transparency, no animation, nothing. Just basic BSPWM with polybar plus my most used app config.

## Packages

### Required command-line utilities

- `rsync`: Most of my backup scripts use rsync. [rsync.samba.org](https://rsync.samba.org/) | [rsync Arch Wiki](https://wiki.archlinux.org/title/Rsync).
- `bc` for arbitrary precision numeric processing. [GNU bc](https://www.gnu.org/software/bc/).
- `jq` for command-line JSON processor. [github.com/jqlang/jq](https://github.com/jqlang/jq).

### Display

- **XOrg** (`xorg-server`, `xorg-xsetroot`, `xorg-xrandr`). [Xorg Arch Wiki](https://wiki.archlinux.org/title/Xorg).
- `bspwm` + `sxhkd`. [bspwm Arch Wiki](https://wiki.archlinux.org/title/Bspwm) | [Sxhkd Arch Wiki](https://wiki.archlinux.org/title/Sxhkd).
- `feh` Image viewer and background setter. [feh.finalrewind.org](https://feh.finalrewind.org/) | [feth Arch Wiki](https://wiki.archlinux.org/title/Feh).
- `pcmanfm` GUI file manager. [PCManFM Arch Wki](https://wiki.archlinux.org/title/PCManFM).

### Shell & Terminal

- `zsh` default shell (vanilla). [zsh.org](https://www.zsh.org/) | [Zsh Arch Wiki](https://wiki.archlinux.org/title/Zsh).
- `alacritty` as default terminal. [github.com/alacritty/alacritty](https://github.com/alacritty/alacritty) | [Arch Wiki](https://wiki.archlinux.org/title/Alacritty).
- `rxvt-unicode` + `urxvt-perls` extension for alternative legacy terminal. [rxvt-unicode Arch Wiki](https://wiki.archlinux.org/title/Rxvt-unicode).
- `tmux` terminal miltiplexer. [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki) | [tmux Arch Wiki](https://wiki.archlinux.org/title/Tmux).

### Editors

- `vim` with `vim-airline` and `vim-plug` plugins. [vim.org](https://www.vim.org/) | [Vim Arch Wiki](https://wiki.archlinux.org/title/Vim).
- `nvim` for coding session (using [NvChad](https://github.com/NvChad/NvChad) vim distribution). [neovim.io](https://neovim.io/) | [NeoVim Arch Wiki](https://wiki.archlinux.org/title/Neovim).

## Hardware Topology

```
lstopo -.ascii
┌────────────────────────────────────────────────────────────────────────────────┐
│ Machine (3866MB total)                                                         │
│                                                                                │
│ ┌────────────────────────────────┐  ├┤╶─┬─────┬─────────────┐                  │
│ │ Package L#0                    │      │     │ PCI 00:02.0 │                  │
│ │                                │      │     └─────────────┘                  │
│ │ ┌────────────────────────────┐ │      │                                      │
│ │ │ NUMANode L#0 P#0 (3866MB)  │ │      ├─────┼┤╶───────┬────────────────┐     │
│ │ └────────────────────────────┘ │      │0.2       0.2  │ PCI 01:00.0    │     │
│ │                                │      │               │                │     │
│ │ ┌────────────────────────────┐ │      │               │ ┌────────────┐ │     │
│ │ │ L3 (3072KB)                │ │      │               │ │ Net wlp1s0 │ │     │
│ │ └────────────────────────────┘ │      │               │ └────────────┘ │     │
│ │                                │      │               └────────────────┘     │
│ │ ┌────────────┐  ┌────────────┐ │      │                                      │
│ │ │ L2 (256KB) │  │ L2 (256KB) │ │      ├─────┼┤╶───────┬──────────────┐       │
│ │ └────────────┘  └────────────┘ │      │0.2       0.2  │ PCI 02:00.0  │       │
│ │                                │      │               │              │       │
│ │ ┌────────────┐  ┌────────────┐ │      │               │ ┌──────────┐ │       │
│ │ │ L1d (32KB) │  │ L1d (32KB) │ │      │               │ │ Net eno1 │ │       │
│ │ └────────────┘  └────────────┘ │      │               │ └──────────┘ │       │
│ │                                │      │               └──────────────┘       │
│ │ ┌────────────┐  ┌────────────┐ │      │                                      │
│ │ │ L1i (32KB) │  │ L1i (32KB) │ │      └─────┬──────────────────────────────┐ │
│ │ └────────────┘  └────────────┘ │            │ PCI 00:1f.2                  │ │
│ │                                │            │                              │ │
│ │ ┌────────────┐  ┌────────────┐ │            │ ┌───────────┐  ┌───────────┐ │ │
│ │ │ Core L#0   │  │ Core L#1   │ │            │ │ Block sr0 │  │ Block sda │ │ │
│ │ │            │  │            │ │            │ │           │  │           │ │ │
│ │ │ ┌────────┐ │  │ ┌────────┐ │ │            │ │ 1023 MB   │  │ 298 GB    │ │ │
│ │ │ │ PU L#0 │ │  │ │ PU L#2 │ │ │            │ └───────────┘  └───────────┘ │ │
│ │ │ │        │ │  │ │        │ │ │            └──────────────────────────────┘ │
│ │ │ │  P#0   │ │  │ │  P#2   │ │ │                                             │
│ │ │ └────────┘ │  │ └────────┘ │ │                                             │
│ │ │ ┌────────┐ │  │ ┌────────┐ │ │                                             │
│ │ │ │ PU L#1 │ │  │ │ PU L#3 │ │ │                                             │
│ │ │ │        │ │  │ │        │ │ │                                             │
│ │ │ │  P#1   │ │  │ │  P#3   │ │ │                                             │
│ │ │ └────────┘ │  │ └────────┘ │ │                                             │
│ │ └────────────┘  └────────────┘ │                                             │
│ └────────────────────────────────┘                                             │
└────────────────────────────────────────────────────────────────────────────────┘
┌────────────────────────────────────────────────────────────────────────────────┐
│ Host: hpg7                                                                     │
└────────────────────────────────────────────────────────────────────────────────┘
```
