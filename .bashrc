#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
neofetch

alias ll='ls -al'
alias tmppkg='BUILDDIR=/tmp/makepkg makepkg' 
alias code='flatpak run com.vscodium.codium'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gitauth='eval `ssh-agent` && ssh-add $HOME/.ssh/id_ed25519'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

