#!/bin/sh 

if [ $(bluetoothctl info | grep "Connected: yes" | wc -l) -eq 1 ]; then 
		#echo "$(bluetoothctl info | grep 'Alias' | awk '{print $2}') "
		#echo " $(bluetoothctl info | grep 'Alias' | cut -d ' ' -f2-) "
		echo "[$(bluetoothctl info | grep 'Alias' | cut -d ' ' -f2-)] "
	else 
		echo ""
fi
