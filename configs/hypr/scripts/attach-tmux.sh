#!/usr/bin/env bash

running_tmux_sessions=`tmux ls 2>/dev/null | cut -d ' ' -f1 | awk '{print substr($0, 1, length($0)-1)}'`

if [ -z "$running_tmux_sessions" ]; then
  echo "No tmux sessions"
  notify-send -r 402 -t 1000 "No tmux sessions"
  exit 1
fi

selected_session=`echo "$running_tmux_sessions" | rofi -dmenu -fuzzy`

if [ -z "$selected_session" ]; then
  echo "No session selected"
  exit 1
fi

hyprctl dispatch exec "kitty sh -c 'tmux attach -t \"$selected_session\"'"
