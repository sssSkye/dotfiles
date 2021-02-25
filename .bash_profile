#!/bin/bash

# exports
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

export PATH=$PATH:/opt/Bitwarden
export PATH=$PATH:/opt/DiscordCanary
export EDITOR="vim"
export TERMINAL="st"

if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
    exec startx; 
fi

