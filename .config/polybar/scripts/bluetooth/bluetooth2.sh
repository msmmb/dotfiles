#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 1 ]; then

	if [ $(bluetoothctl info | grep "Connected: yes" | wc -l) -eq 1 ]; then
		echo "bt:cn"
	else
		echo "bt:on"
	fi

elif [ $(bluetoothctl show | grep "Powered: no" | wc -l) -eq 1 ]; then
	echo "bt:off"
fi

