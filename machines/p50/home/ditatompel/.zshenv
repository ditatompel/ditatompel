# XDG
export XDG_CONFIG_HOME="$HOME/.config"

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
export NVM_DIR="$HOME/.config/nvm"
# You can add `--no-use` at the end of below script to postpone using nvm until
# you manually use it. E.g: (..."$NVM_DIR/nvm.sh" --no-use)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
