# ~/.bashrc
#
# Configuration for interactive bash shell
#
# Should be loaded at the beginning of a bash interactive session,
# for reloading do: source ~/.bashrc
#
# See documentation at https://www.gnu.org/software/bash/manual/bash.html
# or with 'man bash' for bash(1) manual
# or with bash --help

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

## KEYBOARD ##

# see virtual keyboard
#setxkbmap fr # AZERTY (fr)
#setxkbmap us # QWERTY (us)

## LANGUAGE AND ENCODING ##

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## XTERM ###

# set xterm values to color terminal
# possible values: xterm, xterm-256color
# see infocmp xterm (TERM value)
export TERM=xterm

## REDIRECTION ##

# don't overwrite target with bash redirection ">"
#set -C

## HISTORY ##

# step forward:  Ctrl-s
# step backward: Ctrl-r
#stty -ixon

# define history file location
export HISTFILE=~/.bash_history

# define the maximum number of history entries
# current session
export HISTSIZE=500
# history file
export HISTFILESIZE=5000

# ignore some commands to store in history
export HISTIGNORE=""

# append current session history to history file instead of overwriting
# when the session is terminated
shopt -s histappend

# store multi-line commands in one history entry
shopt -s cmdhist

# don't put duplicate lines in the history and  by a space character
export HISTCONTROL=ignoreboth

# format history output with timestamp of the command
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

## EDITOR ##

# define default editor
export EDITOR=vim

# make less more friendly for non-text input files, see lesspipe(2)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

## BASH EXTENSIONS ##

# Native:

# enable bash functions
if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# enable bash clean
if [ -f ~/.bash_clean ]; then
  . ~/.bash_clean
fi

# enable bash alias
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Specific:

# enable specific extensions
if [ -f ~/.bashrc_extensions ]; then
  . ~/.bashrc_extensions
fi

## ALIASES ##

alias ll='ls -alh'
alias lx='ls -alhX'
alias rm='trash-put -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias df='df -h'
alias du='du -mhc'
alias ls='ls --color=auto'
alias sh="PS1='sh> ' sh"
alias zsh="PS1='zsh> ' zsh"

## WINDOWS SUBSYSTEM FOR LINUX ##

if grep -q Microsoft /proc/version; then
  export DISPLAY=:0
  alias docker=docker.exe
  alias powershell=powershell.exe
  export LS_COLORS='ow=01;36;40'
fi

## PROMPT ##

# color (compatible dash)
black="$(tput setaf 0)"
BLACK="$(tput bold)${black}"
red="$(tput setaf 1)"
RED="$(tput bold)${red}"
green="$(tput setaf 2)"
GREEN="$(tput bold)${green}"
yellow="$(tput setaf 3)"
YELLOW="$(tput bold)${yellow}"
blue="$(tput setaf 4)"
BLUE="$(tput bold)${blue}"
magenta="$(tput setaf 5)"
MAGENTA="$(tput bold)${magenta}"
cyan="$(tput setaf 6)"
CYAN="$(tput bold)${cyan}"
white="$(tput setaf 7)"
WHITE="$(tput bold)${white}"
NC="$(tput sgr0)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export LINES COLUMNS

pre_prompt() {
    local -i exit_status="$?"
    local u="$(whoami)"
    local h="$(hostname -f)"
    local wd="${PWD}"
    if [ "${wd}" =~ ^${HOME}. ]; then
        local home_sed=$(echo -n ${HOME} | sed 's/\//\\\//g')
        wd=$(echo -n "${wd}" | sed "s/^${home_sed}/~/")
    fi
    if [ ${#wd} -gt 20 ]; then
      wd="${wd:17}"
      wd="...${wd}"
    fi
    local t="$(date --utc "+%H:%M:%S %Z")"
    # extra
    local base_color=${YELLOW}
    local git="$(__git_ps1)"
    local python_env=$(basename "${VIRTUAL_ENV}")
    if [ -z "${pyenv}" ]; then
      python_env=$(basename "${CONDA_DEFAULT_ENV}")
    fi

    local prompt="${base_color}${u}@${h}:${wd}${NC}${BLUE}${git}${NC}${base_color} - ${t} \\$]${NC}"
    if [ -n ${python_env} ]; then
        prompt="${GREEN}${python_env}${NC}${prompt}"
    fi
    if [ ${exit_status} -ne 0 ]; then
        prompt="${RED}${exit_status}${NC}${base_color}|${NC}${prompt}"
    fi
    prompt="${base_color}[${NC}${prompt}\n"
    export PS1="${prompt}"
}
PROMPT_COMMAND=pre_prompt
