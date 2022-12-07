#!/bin/bash

used=`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader | cut -b 1-2 | cut -b 1-2 | tr -d ' .'`
echo "$used%"
