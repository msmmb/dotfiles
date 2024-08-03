#!/bin/bash

COLOR="%{F#aeee00}" 

memory_usage=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits)
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

used_memory=$(echo $memory_usage | cut -d ',' -f 1)
total_memory=$(echo $memory_usage | cut -d ',' -f 2)

percentage=$(echo "scale=1; $used_memory / $total_memory * 100" | bc)

if awk -v usage="$gpu_usage" 'BEGIN {exit (usage > 10)}'; then
    gpu_usage=""
else
    gpu_usage="$COLOR GPU: $gpu_usage% %{F-}"
fi

if awk -v usage="$percentage" 'BEGIN {exit (usage > 10)}'; then
    used_memory=""
    percentage=""
else
    used_memory="$COLOR VRAM: $used_memory MiB %{F-}"
    percentage="$COLOR($percentage%)%{F-} "
fi

echo "$gpu_usage$used_memory$percentage"

