#!/bin/sh

hyprctl -j activewindow | jq '.initialTitle' | tr -d '"'
