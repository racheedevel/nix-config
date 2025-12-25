#!/bin/bash
selected_setup=$(ls ~/.scripts/tmux/ | xargs -L 1 basename | rofi -dmenu -fuzzy)
# dunstify $selected_setup
bash ~/.scripts/tmux/$selected_setup
