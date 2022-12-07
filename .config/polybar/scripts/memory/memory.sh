#!/bin/sh

mem_used=$(free -m --si | awk '/^Mem:/ {print $3}')M
mem_per=$(free | grep Mem | awk '{print $3/$2 * 100.0}'| bc -l | xargs printf "%.0f")


#echo "ram: $mem_used MB "
echo "$mem_used ($mem_per%)"
