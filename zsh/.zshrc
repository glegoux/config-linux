# ~/.zshrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# basic commands
alias ll='ls -alh'
alias lx='ls -alhX'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias df='df -h'
alias du='du -mhc'
alias ls='ls --color=auto'

# color
autoload -U colors && colors

# prompt
precmd() {
    local -i exit_status="$?"
    local u="$(whoami)"
    local h="$(hostname)"
    local t="$(date "+%H:%M:%S")"
    local wd="${PWD}"
    local zsh="%{$fg_bold[blue]%}(zsh)%{$reset_color%}"
    local color="%{$fg_bold[yellow]%}"
    p="${zsh}${color}[${u}]-[${t}]-\$ %{$reset_color%}"
    if [[ ${exit_status} -ne 0 ]]; then
        ep="%{$fg_bold[red]%}${exit_status}%{$reset_color%}"
        p="${zsh}${color}[%{$reset_color%}${ep}%{$fg_bold[yellow]%}|${u}]-[${t}]-$ %{$reset_color%}"
    fi
    export PS1="${p}"
}
