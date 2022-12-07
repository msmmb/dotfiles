#!/bin/sh

echo " swap: $(free -m --si | awk '/^Swap:/ {print $3}') MB"
