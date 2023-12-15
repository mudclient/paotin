#!/usr/bin/env bash

export LANG=en_US.UTF8
export TERM=xterm-256color

export LESS="-r -f"
export PATH=$HOME/bin:$PATH
export PS1='\[\033[1;49;32m\]MUD\[\033[0m\]:\[\033[33m\]\w\[\033[0m\]\$ '

set -o vi

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

alias ll='ls -l'
alias l='ls -lah'
alias vim=nvim
alias vi=nvim
