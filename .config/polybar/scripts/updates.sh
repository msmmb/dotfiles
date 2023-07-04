#!/bin/sh

sleep 5

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    updates="$(checkupdates | wc -l 2>/dev/null)" 
    #updates="$(paru -Qu | wc -l 2>/dev/null)" 
    if [ "$updates" -ne "0" ]; then
        echo $updates
	else
		echo ""
    fi
else
    echo ""
fi

