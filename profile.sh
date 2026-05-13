#!/usr/bin/env bash

export LANG=en_US.UTF-8
export TERM=xterm-256color
export EDITOR=nvim

export LSCOLORS=Gxfxcxdxbxegedabagacad
export LESS="-r -f --mouse"
export PATH=$HOME/bin:$PATH
export PS1='\[\033[1;49;32m\]MUD\[\033[0m\]:\[\033[33m\]\w\[\033[0m\]\$ '

set -o vi

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

alias ll='ls --color -lh'
alias l='ls --color -lah'
alias vim=nvim
alias vi=nvim

alias gst='git status'
alias glc='tig --all'
alias gco='git checkout'
alias gcb='git checkout -b'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias gba='git branch -a'
alias gbb='git bv'
alias gdf='git -p diff'
alias gdca='git diff --cached'
alias gsh='git show'
alias grv='git remote -v'

command -v starship >/dev/null && eval "$(starship init bash)"
