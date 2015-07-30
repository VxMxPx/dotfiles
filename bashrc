#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Some more aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias phpunit='phpunit --colors'
#alias php='~/.php7/php-src/sapi/cli/php'
alias php-server='php -S localhost:8000'
#alias mysli='cd ~/Projects/mysli.dev/code'
alias php7='~/.php7/php-src/sapi/cli/php'
alias php7-server="~/.php7/php-src/sapi/cli/php -S localhost:8000"
alias vbox='sudo modprobe -a vboxdrv vboxnetflt vboxnetadp'
alias ..='cd ..'
alias ...='cd ../..'
#alias upme='yaourt -Syua'
alias upme='yaourt -Syua; sudo paccache -r; sudo paccache -ruk0'
alias net-access='/home/marko/.scripts/scripts/net-access.sh'
alias ssh-server='ssh marko@mystic-server'
alias yesno='~/.scripts/scripts/yesno.py'
alias xrun='~/.scripts/xrun'
# Git
alias gicm='git commit -m'
alias gip='git push'
alias giaa='git add --all'
alias gia='git add'
alias gis='git status'
alias gid='git diff'
#alias phpt='/home/marko/Projects/phpt/run-tests.php --show-diff'
alias phpt='/home/marko/Projects/mysli.dev/code/private/dot phpt -t'
alias tflix='pirate-get --color -p 2 --custom "peerflix %s && smplayer http://192.168.1.180:8888"'

# PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;30m\](\[\033[00m\]\[\033[00;37m\]\w\[\033[00m\]\[\033[01;30m\])\[\033[00m\]\n\[\033[01;30m\]➜\[\033[00m\] '
# PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;30m\](\[\033[00m\]\[\033[00;37m\]\w\[\033[00m\]\[\033[01;30m\])\[\033[00m\]\n\[\033[01;30m\]➜\[\033[00m\] '
PS1='\n${debian_chroot:+($debian_chroot)}\[\e[38;5;246m\](\w)\[\e[0m\]\n\[\e[38;5;240m\]›\[\e[0m\] '

export EDITOR="nano"
export HISTCONTROL=ignorespace

# Make new tabs inherit current directory in Gnome Terminal
source /etc/profile.d/vte.sh
