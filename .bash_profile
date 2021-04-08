#!/bin/bash

# exports
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

if [ -d "/opt/Bitwarden" ]; then
    export PATH=$PATH:/opt/Bitwarden
fi

if [ -d "/opt/DiscordCanary" ]; then
    export PATH=$PATH:/opt/DiscordCanary
fi

export EDITOR="vim"
export TERMINAL="st"

if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then 
    exec startx; 
fi

