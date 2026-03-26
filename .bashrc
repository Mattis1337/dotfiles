#
# ~/.bashrc
#
export EDITOR="nvim"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
fastfetch

source $HOME/build/repos/OpenFOAM-v2412/etc/bashrc

alias ll='ls -al'
alias tmppkg='BUILDDIR=/tmp/makepkg makepkg' 
alias gitauth='eval `ssh-agent` && ssh-add $HOME/.ssh/id_ed25519 && ssh-add $HOME/.ssh/sign_ed25519'
alias gp='git pull'
alias cmatrix='cmatrix -C cyan'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

. "$HOME/.cargo/env"
