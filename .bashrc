#!/bin/bash
pfetch

# exports
if [ -d "$HOME/bin" ]
then
    export PATH=$PATH:$HOME/bin
fi

export EDITOR="vim"
export TERMINAL="st"

# prompt
export PS1="\[$(tput bold)\][\[$(tput sgr0)\]\[\033[38;5;219m\]\w\[$(tput sgr0)\]\[$(tput bold)\]]\[$(tput sgr0)\] \[$(tput bold)\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

# misc
stty -ixon
shopt -s autocd

# load aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

