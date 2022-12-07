#!/bin/bash

if [[ $(xrandr --listmonitors | grep "HDMI" | wc -l) -ge 1 ]]
then
  bspc monitor HDMI-1-1 -d  I II III IV V
  bspc monitor eDP-1-1 -d VI
  xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.0 --pos 0x0 --rotate normal --output HDMI-1-1 --primary --mode 1920x1080 --rate 60.0 --pos 1920x0 --rotate normal
  bspc monitor HDMI-1-1 -s eDP-1-1
else
  bspc monitor eDP-1-1 -d I II III IV V
fi
