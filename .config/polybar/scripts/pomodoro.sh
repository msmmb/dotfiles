#!/bin/sh

status=$(i3-gnome-pomodoro status)
orange=%{F#ffa717}
blue=%{F#17f1ff}
green=%{F#41ff17}

if [[ $status != "" ]]; then

    if echo $status | grep -q "PAUSED"; then

        if echo $status | grep -q "Pomodoro"; then
            echo "$orange work  "
        elif echo $status | grep -q "Long"; then
            echo "$blue long  "
        elif echo $status | grep -q "Break"; then
            echo "$green break  "
        fi

    else

        time=$(i3-gnome-pomodoro status | awk '{print $NF}')
        time=$(((10#${time%:*})+1))

        if echo $status | grep -q "Pomodoro"; then
            echo "$orange work $time'"
        elif echo $status | grep -q "Long"; then
            echo "$blue long $time'"
        elif echo $status | grep -q "Break"; then
            echo "$green break $time'"
        fi

    fi

else

    echo ""

fi
