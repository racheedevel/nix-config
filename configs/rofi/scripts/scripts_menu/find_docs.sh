#!/usr/bin/env bash
# selection=$(find /home/rachee/docs -name "*.pdf" | rofi -dmenu -p "docs" -keep-right)

function open_file() {

  if [[ -n $selection ]]; then
    newspaceid=$(hyprctl workspaces -j | jq '[.[]] | max_by(.id) | .id + 1')

    # hyprctl dispatch exec [workspace $newspaceid] -- zathura $1
    zathura $1
  fi
}

selection="/home/rachee/docs"
finished=false
while [[ -d $selection ]]; do
  if [[ $selection == "q" ]]; then
    exit 0
  fi

  newselection=$(find ${selection} -maxdepth 1 -not -path '*/.*' | awk -F/ '{print $NF}' | rofi -dmenu -p "docs" -keep-right)
  selection=$selection/$newselection

done
echo $selection
open_file $selection
