# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(2)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# choose type of keyboard AZERTY(fr)/QWERTY(us) (see virtual keyboard)
setxkbmap us

# don't overwrite with >
#set -C

# command history
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# enable bash functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable browsing history
if [ -f ~/.bashrc_bhist ]; then
      . ~/.bashrc_bhist
fi

# enable browsing history aliases
if [ -f ~/.bash_aliases_bhist ]; then
      . ~/.bash_aliases_bhist
fi

# enable git config
if [ -f ~/.bashrc_git ]; then
    . ~/.bashrc_git
fi

# enable bash clean
if [ -f ~/.bash_clean ]; then
    . ~/.bash_clean
fi

# enable bash alias
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# basic commands
alias ll='ls -alh'
alias lx='ls -alhX'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias df='df -h'
alias du='du -mhc'
alias ls='ls --color=auto'

# MANAGE PROMPT
# color
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
blue='\[\033[0;34m\]'
coldblue='\[\033[0;38;5;33m\]'
BLUE='\[\033[1;34m\]'
magenta='\[\033[0;35m\]'
MAGENTA='\[\033[1;35m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export LINES COLUMNS

pre_prompt() {
    local exit_status="$?"
    local u="$(whoami)"
    local h="$(hostname)"
    local g="$(__git_ps1)"
    local wd="${PWD}"
    if [[ "${wd}" =~ ^${HOME}. ]]; then
        local home_sed=$(echo -n ${HOME} | sed 's/\//\\\//g')
        wd=$(echo -n "${wd}" | sed "s/^${home_sed}/~/")
    fi
    local l1="[${u}: ${wd}${g}]"
    if [ ${exit_status} -ne 0 ]; then
        l1="[${exit_status}|${u}: ${wd}${g}]"
    fi
    local l1_size=${#l1}

    local t="$(date "+%H:%M:%S")"
    local l2="[$t]-\\$ "

    local d=""
    if [ $COLUMNS -gt $l1_size ]; then
        local delta="$(($COLUMNS-$l1_size))"
        local d=$(for i in `seq 1 $delta`; do echo -n =; done)
    else
        local delta="$(($l1_size-$COLUMNS+3))"
        if [ $delta -lt ${#wd} ]; then
            wd="${wd:$delta}"
            wd="...$wd"
        else
            export PS1="${YELLOW}$u \\$ ${NC}"
            return
        fi
    fi

    local l1="[${u}: ${wd}${g}]${d}"
    if [ ${exit_status} -ne 0 ]; then
        l1="[${RED}${exit_status}${YELLOW}|${u}: ${wd}${g}]${d}"
    fi

    # update prompt
    export PS1="${YELLOW}${l1}\n${YELLOW}${l2}${NC}"
}

PROMPT_COMMAND=pre_prompt
