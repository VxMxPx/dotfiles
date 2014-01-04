#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git-tf='/home/maarko/.git-tf/git-tf'
alias pxtoem='/home/maarko/.pxtoem/pxtoem.py'
alias phpunit='phpunit --colors'
alias php-server='php -S localhost:8000'
alias cd-active-projects='cd ~/Projects/active'
alias vbox='sudo modprobe -a vboxdrv vboxnetflt vboxnetadp'

PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;30m\](\[\033[00m\]\[\033[00;37m\]\w\[\033[00m\]\[\033[01;30m\])\[\033[00m\]\n\[\033[01;30m\]➜\[\033[00m\] '

export EDITOR="nano"

# export PATH=$PATH:/home/maarko/.gem/ruby/2.0.0/bin

# Make new tabs inherit current directory in Gnome Terminal
# source /etc/profile.d/vte.sh

# Fix line wrap in xfce4 terminal
# shopt -s checkwinsize
