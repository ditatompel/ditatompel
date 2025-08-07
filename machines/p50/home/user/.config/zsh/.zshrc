# Created by ditatompel for 5.9

SAVEHIST=50000 # number of commands stored in zsh history file
HISTSIZE=50500 # number of commands that are loaded into memory from history file

# options. See `man zshoptions`
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

# This `NVM_DIR` is uncommented and now placed in ~/.zshenv
# export NVM_DIR="$HOME/.config/nvm"
# You can add `--no-use` at the end of below script to postpone using nvm until
# you manually use it. E.g: (..."$NVM_DIR/nvm.sh" --no-use)
# 
# NOTE: In this machine, NVM already initiated when user login to zsh shell.
# Using `--no-use` here make the `nvm` "just" available from any
# teminal session, but not executing it.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

# Local bin, Go bin, Bun bin
export PATH="$PATH:$HOME/.local/bin:$(go env GOPATH)/bin:$CARGO_HOME/bin:$BUN_INSTALL/bin"

# common Aliases
################
# Colorized output aliases
alias ls="ls --color=auto --group-directories-first --classify"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -c=auto"
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
[ "$TERM" = "alacritty" ] && alias ssh="TERM=xterm-256color ssh"

# Command app Aliases
# ###################
# List Packages That Depend On Another Package with Pacman (by Adam Douglas)
# https://www.adamsdesk.com/posts/pacman-reverse-package-dependencies/
# This require `pactree` which provided by `pacman-contrib` package and `fzf`.
alias pkgdep="pacman -Qq | fzf --preview 'pactree -lur {} | sort' --layout reverse --bind 'enter:execute(pactree -lu {} | sort | less)'"

# App functions
###############
# Copy text content from given file to clipboard.
# This require `cat` and `xclip`.
ccat() {
  if [ -f "$1" ]; then
    cat "$1" | xclip -selection clipboard
  else
    echo "File not found: $1"
  fi
}

# MPV
# yt-dlp is requried
# Search and play YouTube audio
function yta() {
  mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}
# Search and play YouTube video
function ytv() {
  mpv \
    --ytdl-format="bestvideo[height<=?720][vcodec!~='^(vp0?9|av01)']+bestaudio/best" \
    ytdl://ytsearch:"$*"
}

# Yazi wrapper that change the current working directory when exiting Yazi.
# See: https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
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
  ffmpeg -f x11grab -i "$DISPLAY" -video_size 1280x1920 \
    -c:v h264_nvenc -rc constqp -qp 28 "$output"

  echo "Video saved: $output"
}

# In this machine, the `HISHTORY_PATH` and `HISHTORY_SERVER` is set in
# `~/.zshenv` file.
export PATH="$PATH:/home/user/.config/hishtory"
source /home/user/.config/hishtory/config.zsh

# vim: set ts=2 sw=2 et:
