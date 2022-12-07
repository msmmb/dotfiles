#!/bin/sh

#sleep 15

updates=$(checkupdates | wc -l 2>/dev/null)

if [[ updates -eq 0 ]]; then
	updates=""
fi

echo "$updates"

