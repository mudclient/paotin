#!/usr/bin/env bash

export LANG=zh_CN.UTF8
export TERM=xterm-256color

export PATH=$HOME/bin:$PATH
export PS1='\[\033[01;40;32m\]MUD\[\033[00m\]:\[\033[33m\]\w\[\033[00m\]\$ '

alias ll='ls -l'
alias vim=vi
set -o vi
