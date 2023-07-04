#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -eq 1 ]; then
	 bluetoothctl power off
else
	 bluetoothctl power on
fi
