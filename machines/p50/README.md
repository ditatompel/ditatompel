# ThinkPad P50 Config

Replacement for my [ThinkPad T420](../t420).

This is my personal laptop config file. The configurations under this directory
is not intended to _rice_ your desktop. Maybe this dotfiles repo is one of most
boring desktop you ever see, trust me! No compositor, no transparency, no
animation, nothing. Just basic BSPWM with polybar plus my most used app config.

I put my configs and scripts here for my self, to make me easier moving my
machine to the new one if something bad happen to my beloved laptop. But,
if you find it useful for you, just clone and edit to fit with your need.

> This repo is far from complete, I'll update this repo during my spare time.

## System Hardware

- Board: ThinkPad P50 (20EQS44000)
- Processor: Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
- GPU: NVIDIA Quadro M1000M 4GB (GM107GLM)
- Network:
  - Ethernet: 1GbE I219-LM
  - Wireless: Intel® Dual Band Wireless-AC 8260
- Keyboard: SN20M15446 (US Layout, with backlight)
- Battery: Lenovo 00NY491 (4 cells, 66000mWh, 15V)
- Memory: Dual Channel 64GB @ 2133 MT/s (downclocked)
  - ChannelA-DIMM0: 16GB SODIMM DDR4 2400 MT/s Samsung M471A2K43BB1-CRCQ
  - ChannelA-DIMM1: 16GB SODIMM DDR4 2400 MT/s Samsung M471A2K43BB1-CRCQ
  - ChannelB-DIMM0: 16GB SODIMM DDR4 2400 MT/s Samsung M471A2K43BB1-CRCQ
  - ChannelB-DIMM1: 16GB SODIMM DDR4 2400 MT/s Samsung M471A2K43BB1-CRCQ
- Disks:
  - NVMe0: Team MP33 PRO M.2 PCIe SSD 1TB
  - NVMe1: Samsung 256GB
  - SATA: None

TLDR; required packages for this machine running X:

```
xorg-server xorg-xrandr xorg-xinit org-xset org-xsetroot \
mesa nvidia nvidia-utils \
xbindkeys bspwm sxhkd \
alacritty polybar ttf-jetbrains-mono-nerd ttf-font-awesome
```

For list of explicity installed packages (both from official or AUR), see
[PKGS/pacman-Qqe.txt][pacman-Qqe]. For explicity installed packages from AUR
only, see [PKGS/pacman-Qqme.txt][pacman-Qqme].

## Software

- Boot loader : [GRUB][grub_aw] | ([config][grub_cfg]).
- WM: `bspwm` | [Bspwm Arch Wiki][bspwm_aw] | [Sxhkd Arch Wiki][sxhkd_aw].
- Status bar: `polybar` | [GitHub][polybar_gh].

### Shell & Terminal

- vanilla `zsh` | [zsh.org](https://www.zsh.org/) | [Zsh Arch Wiki](https://wiki.archlinux.org/title/Zsh).
- `alacritty` terminal | [github.com/alacritty/alacritty](https://github.com/alacritty/alacritty) | [Arch Wiki](https://wiki.archlinux.org/title/Alacritty).
- `tmux` terminal multiplexer | [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki) | [tmux Arch Wiki](https://wiki.archlinux.org/title/Tmux).

### Editors

- `vim` | [vim.org](https://www.vim.org/) | [Vim Arch Wiki](https://wiki.archlinux.org/title/Vim).
- `nvim` ([config](./home/ditatompel/.config/nvim)) | [neovim.io](https://neovim.io/) | [NeoVim Arch Wiki](https://wiki.archlinux.org/title/Neovim).

### Utilities

- `imagemagick` or `flameshot` for screenshot. | [ImageMagick Arch Wiki][imagemagick_aw] | [flameshot.org](https://flameshot.org/) | [Flameshot Arch Wiki](https://wiki.archlinux.org/title/Flameshot).

## Hardware Topology

```
lstopo -.ascii
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Machine (63GB total)                                                                                          │
│                                                                                                               │
│ ┌────────────────────────────────────────────────────────────────┐  ├┤╶─┬─────┼┤╶───────┬─────────────┐       │
│ │ Package L#0                                                    │      │4.0       4.0  │ PCI 01:00.0 │       │
│ │                                                                │      │               └─────────────┘       │
│ │ ┌────────────────────────────────────────────────────────────┐ │      │                                     │
│ │ │ NUMANode L#0 P#0 (63GB)                                    │ │      ├─────┬─────────────┐                 │
│ │ └────────────────────────────────────────────────────────────┘ │      │     │ PCI 00:02.0 │                 │
│ │                                                                │      │     └─────────────┘                 │
│ │ ┌────────────────────────────────────────────────────────────┐ │      │                                     │
│ │ │ L3 (8192KB)                                                │ │      ├─────┬─────────────┐                 │
│ │ └────────────────────────────────────────────────────────────┘ │      │     │ PCI 00:17.0 │                 │
│ │                                                                │      │     └─────────────┘                 │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │                                     │
│ │ │ L2 (256KB) │  │ L2 (256KB) │  │ L2 (256KB) │  │ L2 (256KB) │ │      ├─────┼┤╶───────┬───────────────────┐ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │3.9       3.9  │ PCI 02:00.0       │ │
│ │                                                                │      │               │                   │ │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │               │ ┌───────────────┐ │ │
│ │ │ L1d (32KB) │  │ L1d (32KB) │  │ L1d (32KB) │  │ L1d (32KB) │ │      │               │ │ Block nvme1n1 │ │ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │               │ │               │ │ │
│ │                                                                │      │               │ │ 238 GB        │ │ │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │               │ └───────────────┘ │ │
│ │ │ L1i (32KB) │  │ L1i (32KB) │  │ L1i (32KB) │  │ L1i (32KB) │ │      │               └───────────────────┘ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │                                     │
│ │                                                                │      ├─────┼┤╶───────┬────────────────┐    │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │0.2       0.2  │ PCI 04:00.0    │    │
│ │ │ Core L#0   │  │ Core L#1   │  │ Core L#2   │  │ Core L#3   │ │      │               │                │    │
│ │ │            │  │            │  │            │  │            │ │      │               │ ┌────────────┐ │    │
│ │ │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │ │      │               │ │ Net wlp4s0 │ │    │
│ │ │ │ PU L#0 │ │  │ │ PU L#2 │ │  │ │ PU L#4 │ │  │ │ PU L#6 │ │ │      │               │ └────────────┘ │    │
│ │ │ │        │ │  │ │        │ │  │ │        │ │  │ │        │ │ │      │               └────────────────┘    │
│ │ │ │  P#0   │ │  │ │  P#1   │ │  │ │  P#2   │ │  │ │  P#3   │ │ │      │                                     │
│ │ │ └────────┘ │  │ └────────┘ │  │ └────────┘ │  │ └────────┘ │ │      ├─────┼┤╶───────┬───────────────────┐ │
│ │ │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │ │      │3.9       3.9  │ PCI 3e:00.0       │ │
│ │ │ │ PU L#1 │ │  │ │ PU L#3 │ │  │ │ PU L#5 │ │  │ │ PU L#7 │ │ │      │               │                   │ │
│ │ │ │        │ │  │ │        │ │  │ │        │ │  │ │        │ │ │      │               │ ┌───────────────┐ │ │
│ │ │ │  P#4   │ │  │ │  P#5   │ │  │ │  P#6   │ │  │ │  P#7   │ │ │      │               │ │ Block nvme0n1 │ │ │
│ │ │ └────────┘ │  │ └────────┘ │  │ └────────┘ │  │ └────────┘ │ │      │               │ │               │ │ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │               │ │ 953 GB        │ │ │
│ └────────────────────────────────────────────────────────────────┘      │               │ └───────────────┘ │ │
│                                                                         │               └───────────────────┘ │
│                                                                         │                                     │
│                                                                         └─────┬───────────────────┐           │
│                                                                               │ PCI 00:1f.6       │           │
│                                                                               │                   │           │
│                                                                               │ ┌───────────────┐ │           │
│                                                                               │ │ Net enp0s31f6 │ │           │
│                                                                               │ └───────────────┘ │           │
│                                                                               └───────────────────┘           │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Host: P50                                                                                                     │
│                                                                                                               │
│ Date: Wed 21 May 2025 11:50:54 PM WIB                                                                         │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

[pacman-Qqe]: ./PKGS/pacman-Qqe.txt "Output of pacman -Qqe"
[pacman-Qqme]: ./PKGS/pacman-Qqme.txt "Output of pacman -Qqme"
[grub_aw]: https://wiki.archlinux.org/title/GRUB "GRUB Arch Wiki"
[grub_cfg]: ./etc/default/grub "GRUB configuration file"
[bspwm_aw]: https://wiki.archlinux.org/title/Bspwm "Bspwm Arch Wiki"
[sxhkd_aw]: https://wiki.archlinux.org/title/Sxhkd "Sxhkd Arch Wiki"
[polybar_gh]: https://github.com/polybar/polybar "Polybar GitHub"
[imagemagick_aw]: https://wiki.archlinux.org/title/ImageMagick "ImageMagick Arch Wiki"
