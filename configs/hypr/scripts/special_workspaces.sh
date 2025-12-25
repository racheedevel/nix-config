#!/bin/bash
current_workspace=$(hyprctl activeworkspace -j | jq '.id')
# IFS=$'\n' read -r -d '' -a wslist < <(hyprctl workspaces -j | jq '.[] | select(.id > 0) | .id' && printf '\0') # WORKS TOO
mapfile -t wslist < <(hyprctl workspaces -j | jq '.[] | select(.id < 0) | .id')
remwslist=()
current_workspace="-99"
for i in "${wslist[@]}"; do
  # ((i < current_workspace)) && remwslist=(${remwslist[@]} $i)
  if [[ $i -lt $current_workspace ]]; then
    remwslist+=($i)
  fi
done

min=${remwslist[0]}

for i in "${remwslist[@]}"; do
  (( i < $min )) && min=$i
done

echo " First element is: $min"
echo "Array is ${remwslist[@]}"
