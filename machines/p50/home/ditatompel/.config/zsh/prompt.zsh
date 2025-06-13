# Ditatompel prompt created by Christian Ditaputratama for 5.9

autoload -Uz compinit vcs_info
compinit
zstyle ':completion:*'              menu select
zstyle ':completion:*'              matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'              select-prompt '%SScroll position: %p%s'
zstyle ':completion:*'              list-dirs-first true
zstyle ':completion:*'              group-name ''
zstyle ':completion:*:matches'      group 'yes'
zstyle ':completion:*:default'      list-colors ${(s.:.)LS_COLORS} ''
zstyle ':completion::complete:*'    use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# VCS
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' formats ' [%b]%u%c'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c)'

# Functions
preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

precmd() {
  vcs_info

  # Exec time
  # See https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44
  if [ $timer ]; then
    local now=$(date +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    local elapsed=""
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else elapsed=${ms}ms
    fi
    unset timer
  fi

  #USER_FMT="%F{green}%n%f"
  # Right now, I don't want to show regular user in the prompt. If you want to
  # show your user in the prompt, uncomment `USER_FMT` above and comment out
  # `USER_FMT` below.
  USER_FMT="%F{green}user%f"
  if [ "$(id -u)" -eq 0 ]; then
    USER_FMT="%F{red}%n%f"
  fi

  PS1="%B${USER_FMT}@%F{cyan}%m%k %(?.%F{green}√.%F{red}?%?)%f %F{yellow}${elapsed}%f %B%F{blue}%~%b%f%k${vcs_info_msg_0_} "$'\n'"%# "
}

# vim: set ts=2 sw=2 et:
