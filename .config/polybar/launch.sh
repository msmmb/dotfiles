#!/usr/bin/env bash

#Terminate already running bar instances
killall -q polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

if [[ $(xrandr --listmonitors | grep "1-1" | wc -l) > 0 ]]
then
	if [[ $(xrandr --listmonitors | grep "HDMI" | wc -l) > 0 ]]
	then
		polybar primary_nvidia 2>&1 | tee -a /tmp/polybar1.log & disown
	else
		polybar laptop_nvidia 2>&1 | tee -a /tmp/polybar2.log & disown
	fi

else
	if [[ $(xrandr --listmonitors | grep "HDMI" | wc -l) > 0 ]]
	then
		polybar primary 2>&1 | tee -a /tmp/polybar1.log & disown
	else
		polybar laptop 2>&1 | tee -a /tmp/polybar2.log & disown
	fi

fi

echo "Bars launched..."
