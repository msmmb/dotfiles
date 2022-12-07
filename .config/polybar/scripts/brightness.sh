#!/bin/sh

b=$(xbacklight -get)
b=${b%.*}

if [[ $b -ge 90 ]]; then
	echo "  $b%"
elif [[ $b -ge 55 ]]; then
	echo "  $b%"
elif [[ $b -ge 20 ]]; then
	echo "  $b%"
else 
	echo "  $b%"
fi

#echo " bl: $b%"
