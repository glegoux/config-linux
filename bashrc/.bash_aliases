# Basic commands
alias ll='ls -alh'
alias lx='ls -alhX'
alias rm='trash-put -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias df='df -h'
alias du='du -mhc'
alias ls='ls --color=auto'

# Go to trash folder on Ubuntu
alias go-trash='cd ~/.local/share/Trash'

# Mount shared folder beetween host and client virtualbox 
alias shared-folder='sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) share ~/share'

# Show bash command history without number
alias chistory='history | cut -c 8-'

# Show file system tree
alias tree='\tree -C'
alias tree+='\tree -CfaQpugh --du --dirsfirst'

# Ardesia (annotate on the desktop screen)
alias ardesia='ardesia -g south -d -t 50'
