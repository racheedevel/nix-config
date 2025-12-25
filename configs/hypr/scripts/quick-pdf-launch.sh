#!/bin/bash

LOCATIONS_FILE="$HOME/.settings/quick_pdf_launch_locations"

if ! [ -f "$LOCATIONS_FILE" ]; then
    echo "$LOCATIONS_FILE Does not exist."
    exit 1
fi

files=$(cat "$LOCATIONS_FILE" | xargs find | grep "\.pdf$")
file_names=$(\
    while IFS= read -r file; do
        basename "$file"
    done <<< "$files"
)

file_name=$(echo "$file_names" | bash ~/.config/rofi/launch-rofi.sh -dmenu -i)
if [ -z "$file_name" ]; then
    echo "No file picked"
    exit 0
fi


file_path="$(\
    echo "$files" | while IFS= read -r file; do
      [[ "$(basename "$file")" == "$file_name" ]] && echo "$file"
    done | head -n1
)"

if [ -z "$file_path" ]; then
    echo "No file picked"
    exit 0
fi

echo "$file_path"

if [ "$1" == "zathura" ]; then
    nohup zathura "$file_path" > /dev/null & disown
else
    chromium "$file_path" --new-window & disown
fi
