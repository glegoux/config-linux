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
    p="%{$fg_bold[yellow]%}[${u}@telecom-paris]-[${t}]-$ %{$reset_color%}"
    if [[ ${exit_status} -ne 0 ]]; then
        ep="%{$fg_bold[red]%}${exit_status}%{$reset_color%}"
        p="%{$fg_bold[yellow]%}[%{$reset_color%}${ep}%{$fg_bold[yellow]%}|${u}@telecom-paris]-[${t}]-$ %{$reset_color%}"
    fi
    export PS1="${p}"
}

