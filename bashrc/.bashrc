# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(2)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# choose type of keyboard AZERTY(fr)/QWERTY(us) (see virtual keyboard)
#setxkbmap fr
#setxkbmap us

# don't overwrite with >
#set -C

# Ctrl-s to step forward 
# Ctrl-r to step backward
stty -ixon

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
alias rm='trash-put -vi'
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

# Git
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export LINES COLUMNS


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

# Personal script & Spark
export PATH="$HOME/bin:$HOME/opt/spark/spark-2.0.1-bin-hadoop2.7/bin:$HOME/opt/spark/spark-2.0.1-bin-ha
doop2.7/sbin:$PATH"

# Anaconda
export ANACONDA_HOME="${HOME}/opt/anaconda3"
export ANACONDA_ENV="conda-stats"

alias conda-start="source ${ANACONDA_HOME}/bin/activate ${ANACONDA_HOME}/envs/${ANACONDA_ENV}"
alias conda-stop="source deactivate ${ANACONDA_ENV}"
