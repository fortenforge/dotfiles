# Linux Bash Profile
# Last Updated: Jan 2017
# Author: fortenforge

# colors and bash prompt customization
alias ls='ls --color'
export PS1="\[\e[0;32m\][\W]>\[\e[m\] "

# useful aliases
search() { find . ${2:+-name "$2"} -type f -print0 | xargs -0 grep "$1"; }

