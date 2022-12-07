#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 1 ]; then

	if [ $(bluetoothctl info | grep "Connected: yes" | wc -l) -eq 1 ]; then
		echo " "
		#echo " "
	else
		echo ""
	fi
else
	echo ""
fi
