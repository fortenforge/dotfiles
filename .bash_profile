export CLICOLOR=1
export LSCOLORS=ExBxhxDxCxhxhxhxhxGxGx

search() { find . -type f -print0 | xargs -0 grep "$1"; }

export PS1="\[\e[0;32m\][\W]>\[\e[m\] "
