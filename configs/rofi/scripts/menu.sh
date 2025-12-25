#!/usr/bin/env bash

# Directory containing your scripts
SCRIPT_DIR="$HOME/scripts/rofi"

# Get list of .sh files, just names
scripts=($(find "$SCRIPT_DIR" -maxdepth 1 -type f -name "*.sh" -exec basename {} \;))

# Add the quit option
scripts+=("q")

# Use rofi to pick a script
chosen=$(printf '%s\n' "${scripts[@]%.sh}" | rofi -dmenu -p "Select script to run" --display-column-separator _ --display-columns 'shortcut,name')

# If q or empty input, quit
if [[ "$chosen" == "q" || -z "$chosen" ]]; then
    exit 0
fi

# Execute the selected script
"$SCRIPT_DIR/${chosen}.sh"
