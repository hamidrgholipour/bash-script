#!/bin/bash

log_file="app.log"

stopped_line=$(grep "Total time for which application threads were stopped" "$log_file")


while read -r stopped_line;do
        date=$(echo "$stopped_line" | awk '{ gsub(":", "", $1); print $1 }')
        stopped_time=$(echo "$stopped_line" | awk '{print $11}')

        if [ "$(echo "$stopped_time > 3" | bc)" -eq 1 ] && [ "$(echo "$stopped_time < 5" | bc)" -eq 1 ]; then
                echo "[$date] [stopped: $stopped_time]" >> gc-$(date +%Y-%m-%d).log
        elif [ "$(echo "$stopped_time > 5" | bc)" -eq 1 ]; then
                echo "Restart" >> log-$(date +%Y-%m-%d).log
        fi

done <<< "$stopped_line"
