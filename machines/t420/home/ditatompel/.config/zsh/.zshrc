# Created by ditatompel for 5.9

SAVEHIST=50000 # number of commands stored in zsh history file
HISTSIZE=50500 # number of commands that are loaded into memory from history file

# options. See `man zshoptions
setopt PROMPT_SUBST

#setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# load the prompt
. "${ZDOTDIR}/prompt.zsh"

# xterm title
autoload -Uz add-zsh-hook up-line-or-beginning-search down-line-or-beginning-search

function xterm_title_precmd () {
  print -Pn -- '\e]2;%n@%m %~\a'
  [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
  print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
  [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
  add-zsh-hook -Uz precmd xterm_title_precmd
  add-zsh-hook -Uz preexec xterm_title_preexec
fi

# History search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
# Shift, Alt, Ctrl and Meta modifiers
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-beginning-search   # OR up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-beginning-search # OR down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# non-terminfo (using showkey -a) maybe different with yours
#bindkey "^H" backward-kill-word # control Backspace
bindkey "^[^H" backward-kill-word # Control+Alt+Backspace
bindkey "^[[3;5~" kill-word # control Delete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm

# PATHs
#######
# Local bin, Go bin, Bun bin
#export PATH="$PATH:$HOME/.local/bin:$(go env GOPATH)/bin:$BUN_INSTALL/bin"
export PATH="$PATH:$HOME/.local/bin:$(go env GOPATH)/bin:$CARGO_HOME/bin:$BUN_INSTALL/bin"

# common Aliases
################
# Colorized output aliases
alias ls="ls --color=auto --human-readable --group-directories-first --classify"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -c=auto"

# Command app Aliases
alias msfconsole="msfconsole --quiet -x \"db_connect ${USER}@msf\""
# alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/src/ditatompel-dotfiles/ --work-tree=$HOME'
alias alacritty="WINIT_X11_SCALE_FACTOR=1.33 alacritty"
# List Packages That Depend On Another Package with Pacman (by Adam Douglas)
# https://www.adamsdesk.com/posts/pacman-reverse-package-dependencies/
# This require fzf and pactree which provided by `pacman-contrib` package.
alias pkgdep="pacman -Qq | fzf --preview 'pactree -lur {} | sort' --layout reverse --bind 'enter:execute(pactree -lu {} | sort | less)'"
[ "$TERM" = "alacritty" ] && alias ssh="TERM=xterm-256color ssh"

# App functions
###############
# xclip
ccat() {
  if [ -f "$1" ]; then
    cat "$1" | xclip -selection clipboard
  else
    echo "File not found: $1"
  fi
}

# MPV
# youtube-dl is requried
# Search and play YouTube audio
function yta() {
  mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}
# Search and play YouTube video
function ytv() {
  mpv --ytdl-format='bestvideo[height<=?720]+bestaudio/best' ytdl://ytsearch:"$*"
}

# Pull and merge shortcut for personal projects
# $1 = remote origin
# $2 = destination branch
# $3 = source branch
function pullandmerge() {
  git pull "$1" "$2" && git checkout "$3" && git merge "$2" && git push -u "$1" "$3"
}

# Screen recording
# This is wrapper function to record screen using ffmpeg (without audio).
function screenrecord () {
  local output="record.mkv"
  if [[ "$1" == *.mkv ]]; then
    output="$1"
  fi

  # To take a screencast with lossless encoding and without audio:
  # ffmpeg -f x11grab -i "$DISPLAY" -video_size 1280x1920 -c:v ffvhuff "$output"

  # When using the proprietary NVIDIA driver with the nvidia-utils,
  # NVENC and NVDEC can be used for encoding/decoding.
  # To print available options execute (hevc_nvenc may also be available):
  # ffmpeg -help encoder=h264_nvenc
  # See; https://wiki.archlinux.org/title/FFmpeg#NVIDIA_NVENC/NVDEC
  ffmpeg -f x11grab -video_size 1280x1024 -framerate 60 -i $DISPLAY \
    -f pulse -i 0 -c:v libx264 -preset ultrafast -c:a aac "$output"

  echo "Video saved: $output"
}

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Hishtory Config
# In this machine, the `HISHTORY_PATH` and `HISHTORY_SERVER` is set in
# `~/.zshenv` file.
export PATH="$PATH:/home/ditatompel/.config/hishtory"
source /home/ditatompel/.config/hishtory/config.zsh

# vim: set ts=2 sw=2 et:
