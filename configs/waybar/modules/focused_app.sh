#!/usr/bin/env bash

hyprctl -j activewindow | jq '.initialTitle' | tr -d '"'
