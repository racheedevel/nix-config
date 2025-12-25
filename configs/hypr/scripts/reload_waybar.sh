#!/bin/bash

hyprctl notify 3 1000 0 "Reloading waybar..."

killall waybar

waybar
