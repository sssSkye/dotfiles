#!/bin/sh

while true; do
    xsetroot -name "$(sh /home/skye/bin/currentxkbmap) | $(date +"%b %d %I:%M%P") | $(uname -r -s)"
    sleep 2
done

