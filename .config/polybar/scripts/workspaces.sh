#!/bin/bash

if [ "$1" = "www" ]; then
    program=firefox
	bspc desktop -f '^1'
elif [ "$1" = "term" ]; then
    program=alacritty
	bspc desktop -f '^2'
elif [ "$1" = "text" ]; then
    program=code
	bspc desktop -f '^3'
elif [ "$1" = "music" ]; then
    program=spotify
	bspc desktop -f '^4'
fi

if ! bspc query -D -d .occupied --names | grep -q "$1"; then
    "$program"
fi

