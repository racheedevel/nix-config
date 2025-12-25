#!/bin/bash

hyprctl dispatch focusmonitor "$(hyprctl activeworkspace -j | jq '.monitor')" > /dev/null 2>&1

random_class=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 50; echo)
cat - | rofi -normal-window --class "$random_class" $@ &
exec > /dev/null 2>&1
rofi_pid=$(ps aux | grep "$random_class" | grep -v grep | awk '{print $2}')

hyprctl dispatch focuswindow Rofi > /dev/null
sleep 0.2
hyprctl dispatch focuswindow Rofi > /dev/null

# echo "CURRENT: $(hyprctl activewindow -j | jq '.pid')"
# echo "ROFI: $rofi_pid"

while [[ "$(hyprctl activewindow -j | jq '.pid')" == "$rofi_pid" ]]
do
    # hyprctl activewindow -j | jq '.pid'
    sleep 0.1
done

kill -9 "$rofi_pid"
