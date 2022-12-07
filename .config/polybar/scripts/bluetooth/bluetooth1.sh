#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 1 ]; then

	if [ $(bluetoothctl info | grep "Connected: yes" | wc -l) -eq 1 ]; then
		device=$(bluetoothctl info | grep 'Alias' | awk '{print $2}')
		echo ""
	else
		echo " "
	fi

elif [ $(bluetoothctl show | grep "Powered: no" | wc -l) -eq 1 ]; then
	echo " "
fi

