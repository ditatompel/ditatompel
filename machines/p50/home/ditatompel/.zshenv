# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Editor
export EDITOR="/usr/bin/nvim"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"

# Rust
export RUSTUP_HOME="$HOME/.local/work/rustup"
export CARGO_HOME="$HOME/.local/work/cargo"

# Go
export GOPATH="$HOME/.local/work/go"

# Bun
export BUN_INSTALL="$HOME/.local/work/bun"

# Nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# You can add `--no-use` at the end of below script to postpone using nvm until
# you manually use it. E.g: (..."$NVM_DIR/nvm.sh" --no-use)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# Docker
DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# NVIDIA Cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# Wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# Ansible
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"

# Colorized manpage (less)
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"
