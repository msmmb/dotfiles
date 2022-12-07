#!/bin/bash

if [[ $(xrandr --listmonitors | grep "HDMI" | wc -l) -ge 1 ]]
then
  bspc monitor HDMI1 -d I II III IV V 
  #bspc monitor DP-1-0 -d 6 7 8 9 10 
  bspc monitor eDP1 -d VI
  xrandr --output eDP1 --mode 1920x1080 --rate 144.0 --pos 0x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --rate 60.0 --pos 1920x0 --rotate normal
  #xrandr --output DP-1-0 --mode 1920x1080 --rate 74.97 --pos 0x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --rate 60.0 --pos 1920x0 --rotate normal
  bspc monitor HDMI1 -s eDP1
else
  #xrandr --output HDMI1 --off
  #bspc monitor HDMI1 -r
  bspc monitor eDP1 -d  I II III IV V
fi
