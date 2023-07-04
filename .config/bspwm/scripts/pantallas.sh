#!/bin/sh

bspc subscribe monitor_geometry | while read -r Event
do

#bspc desktop -s prev.active
killall polybar
bspc config top_padding 0
feh --bg-fill /home/michael/Imágenes/Fondos\ de\ Pantalla/39.jpg

if [[ $(xrandr --listmonitors  | grep '1-1' | wc -l) -ge 1 ]]
then
  $HOME/.config/bspwm/scripts/nvidia.sh
  $HOME/.config/bspwm/scripts/nvidia.sh
  $HOME/.config/bspwm/scripts/nvidia.sh
  $HOME/.config/polybar/launch.sh
else
  $HOME/.config/bspwm/scripts/intel_hybrid.sh
  $HOME/.config/bspwm/scripts/intel_hybrid.sh
  $HOME/.config/bspwm/scripts/intel_hybrid.sh
  $HOME/.config/polybar/launch.sh
fi


done &
