# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Make less more friendly for non-text input files, see lesspipe(2)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Choose type of keyboard AZERTY(fr)/QWERTY(us) (see virtual keyboard)
#setxkbmap fr
#setxkbmap us

# don't overwrite with >
#set -C

# Search through shell command history
# Ctrl-s to step forward 
# Ctrl-r to step backward
stty -ixon

# Command history
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Enable extensions
# bash
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bashrc_bhist ]; then
      . ~/.bashrc_bhist
fi

if [ -f ~/.bash_clean ]; then
    . ~/.bash_clean
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bhist
if [ -f ~/.bash_aliases_bhist ]; then
      . ~/.bash_aliases_bhist
fi

# git
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

if [ -f ~/.bashrc_git ]; then
    . ~/.bashrc_git
fi

# Manage Bash prompt
# color
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
orange='\[\033[0;38;5;215m\]'
ORANGE='\[\033[1;38;5;215m\]'
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

# Check window size after each command
shopt -s checkwinsize
export LINES COLUMNS

# Bash prompt on 2 lines with:
# - last shell command exit status if error (> 0)
# - git prompt if context is in git reposiory
# - python prompt if virtualenv or conda env activated
pre_prompt() {
    # get exit status all right
    local -i exit_status="$?"
    # line 1 without color
    local color=${YELLOW}
    local u="$(whoami)"
    local h="$(hostname)"
    # for git prompt
    local g="$(__git_ps1)"
    local wd="${PWD}"
    if [[ "${wd}" =~ ^${HOME}. ]]; then
        local home_sed=$(echo -n ${HOME} | sed 's/\//\\\//g')
        wd=$(echo -n "${wd}" | sed "s/^${home_sed}/~/")
    fi
    local l1="${u}: ${wd}${g}"
    local pyenv=$(basename "${VIRTUAL_ENV}")
    if [ -z "${pyenv}" ]; then
      pyenv=$(basename "${CONDA_DEFAULT_ENV}")
    fi 
    if [ -n "${pyenv}" ]; then
      pyenv="(${pyenv}) "
      l1="${pyenv}${l1}"
    fi
    if [[ ${exit_status} -ne 0 ]]; then
        l1="${exit_status}|${l1}"
    fi
    l1="[${l1}]"
    # responsive prompt if line 1 too long
    local l1_size=${#l1}
    local d=""
    local delta=""
    if [[ ${COLUMNS} -gt ${l1_size} ]]; then
        delta="$((${COLUMNS}-${l1_size}))"
        if [[ ${TERM} != "ansi" ]]; then
            # if terminal is not for eclipse
            d=$(for i in `seq 1 ${delta}`; do echo -n =; done)
        fi
    else
        delta="$((${l1_size}-${COLUMNS}+3))"
        if [[ ${delta} -lt ${#wd} ]]; then
            wd="${wd:${delta}}"
            wd="...${wd}"
        else
            # impossible to resize prompt
            export PS1="${color}$u \\$ ${NC}"
            return
        fi
    fi
    # line 1 with color
    pyenv="${GREEN}${pyenv}${NC}${YELLOW}"
    if [[ ${exit_status} -eq 0 ]]; then
        l1="${color}[${pyenv}${u}: ${wd}${g}]${d}"
    else
        l1="${color}[${RED}${exit_status}${color}|${pyenv}${u}: ${wd}${g}]${d}"
    fi
    # line 2 with color
    local t="$(date "+%H:%M:%S")"
    local l2="${color}[$t]-\\$ ${NC}"
    export PS1="${l1}\n${l2}"

}

PROMPT_COMMAND=pre_prompt
