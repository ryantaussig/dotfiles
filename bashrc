# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# pretty prompt
export PS1="[\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[34m\]\w\[\e[m\]]\\$ "

# custom gruvbox color palette for vim
source "$HOME/dotfiles/gruvbox-256palette.sh"
