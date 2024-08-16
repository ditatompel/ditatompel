# ThinkPad P50 Config

Replacement for my [ThinkPad T420](../t420).

This repo is far from complete, I'll update this repo during my spare time.

## System Hardware

- Board: ThinkPad P50 (20EQS44000)
- Processor: Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
- GPU: NVIDIA Quadro M1000M 4GB (GM107GLM)
- Network:
  - Ethernet: 1GbE I219-LM
  - Wireless: Intel® Dual Band Wireless-AC 8260
- Keyboard: SN20H35185 (UK/EU Layout, no backlight)
- Battery: Lenovo 00NY491 (4 cells, 66000mWh, 15V)
- Memory: 8GB/64GB
  - ChannelA-DIMM0: 8GB SODIMM DDR4 2133 MT/s Samsung M471A1K43CB1-CRC
  - ChannelA-DIMM1: None
  - ChannelB-DIMM0: None
  - ChannelB-DIMM1: None
- Disks:
  - NVMe0: Samsung 256GB
  - NVMe1: None
  - SATA: None

## Software

- Boot loader : [GRUB](https://wiki.archlinux.org/title/GRUB) ([config](./etc/default/grub)).

### Shell & Terminal

- vanilla `zsh` | [zsh.org](https://www.zsh.org/) | [Zsh Arch Wiki](https://wiki.archlinux.org/title/Zsh).
- `alacritty` terminal | [github.com/alacritty/alacritty](https://github.com/alacritty/alacritty) | [Arch Wiki](https://wiki.archlinux.org/title/Alacritty).
- `tmux` terminal miltiplexer | [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki) | [tmux Arch Wiki](https://wiki.archlinux.org/title/Tmux).

### Editors

- `vim` | [vim.org](https://www.vim.org/) | [Vim Arch Wiki](https://wiki.archlinux.org/title/Vim).
- `nvim` ([config](./home/ditatompel/.config/nvim)) | [neovim.io](https://neovim.io/) | [NeoVim Arch Wiki](https://wiki.archlinux.org/title/Neovim).

## Hardware Topology

```
lstopo -.ascii
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Machine (7836MB total)                                                                                        │
│                                                                                                               │
│ ┌────────────────────────────────────────────────────────────────┐  ├┤╶─┬─────┼┤╶───────┬─────────────┐       │
│ │ Package L#0                                                    │      │4.0       4.0  │ PCI 01:00.0 │       │
│ │                                                                │      │               └─────────────┘       │
│ │ ┌────────────────────────────────────────────────────────────┐ │      │                                     │
│ │ │ NUMANode L#0 P#0 (7836MB)                                  │ │      ├─────┬─────────────┐                 │
│ │ └────────────────────────────────────────────────────────────┘ │      │     │ PCI 00:17.0 │                 │
│ │                                                                │      │     └─────────────┘                 │
│ │ ┌────────────────────────────────────────────────────────────┐ │      │                                     │
│ │ │ L3 (8192KB)                                                │ │      ├─────┼┤╶───────┬────────────────┐    │
│ │ └────────────────────────────────────────────────────────────┘ │      │0.2       0.2  │ PCI 04:00.0    │    │
│ │                                                                │      │               │                │    │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │               │ ┌────────────┐ │    │
│ │ │ L2 (256KB) │  │ L2 (256KB) │  │ L2 (256KB) │  │ L2 (256KB) │ │      │               │ │ Net wlp4s0 │ │    │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │               │ └────────────┘ │    │
│ │                                                                │      │               └────────────────┘    │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │                                     │
│ │ │ L1d (32KB) │  │ L1d (32KB) │  │ L1d (32KB) │  │ L1d (32KB) │ │      ├─────┼┤╶───────┬───────────────────┐ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │3.9       3.9  │ PCI 3e:00.0       │ │
│ │                                                                │      │               │                   │ │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │               │ ┌───────────────┐ │ │
│ │ │ L1i (32KB) │  │ L1i (32KB) │  │ L1i (32KB) │  │ L1i (32KB) │ │      │               │ │ Block nvme0n1 │ │ │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │      │               │ │               │ │ │
│ │                                                                │      │               │ │ 238 GB        │ │ │
│ │ ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐ │      │               │ └───────────────┘ │ │
│ │ │ Core L#0   │  │ Core L#1   │  │ Core L#2   │  │ Core L#3   │ │      │               └───────────────────┘ │
│ │ │            │  │            │  │            │  │            │ │      │                                     │
│ │ │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │ │      └─────┬───────────────────┐           │
│ │ │ │ PU L#0 │ │  │ │ PU L#2 │ │  │ │ PU L#4 │ │  │ │ PU L#6 │ │ │            │ PCI 00:1f.6       │           │
│ │ │ │        │ │  │ │        │ │  │ │        │ │  │ │        │ │ │            │                   │           │
│ │ │ │  P#0   │ │  │ │  P#1   │ │  │ │  P#2   │ │  │ │  P#3   │ │ │            │ ┌───────────────┐ │           │
│ │ │ └────────┘ │  │ └────────┘ │  │ └────────┘ │  │ └────────┘ │ │            │ │ Net enp0s31f6 │ │           │
│ │ │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │  │ ┌────────┐ │ │            │ └───────────────┘ │           │
│ │ │ │ PU L#1 │ │  │ │ PU L#3 │ │  │ │ PU L#5 │ │  │ │ PU L#7 │ │ │            └───────────────────┘           │
│ │ │ │        │ │  │ │        │ │  │ │        │ │  │ │        │ │ │                                            │
│ │ │ │  P#4   │ │  │ │  P#5   │ │  │ │  P#6   │ │  │ │  P#7   │ │ │                                            │
│ │ │ └────────┘ │  │ └────────┘ │  │ └────────┘ │  │ └────────┘ │ │                                            │
│ │ └────────────┘  └────────────┘  └────────────┘  └────────────┘ │                                            │
│ └────────────────────────────────────────────────────────────────┘                                            │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Host: p50                                                                                                     │
│                                                                                                               │
│ Date: Tue 13 Aug 2024 08:39:28 PM WIB                                                                         │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```
