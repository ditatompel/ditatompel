# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# X11
#export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

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

# Pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# Ansible
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"

# MariaDB
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

# Hishtory
export HISHTORY_PATH=.config/hishtory
export HISHTORY_SERVER="http://127.0.0.1:45680"

# Colorized manpage (less)
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Change the default password prompt for sudo.
# See manual page of inline `-p` or `--prompt` for available escape sequences.
# Eg: export SUDO_PROMPT=$'\a[sudo] password for %p: '
export SUDO_PROMPT=$'\a[sudo] Prove you\'re worthy, enter the holy key: '
