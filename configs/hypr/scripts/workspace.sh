monitors=$(hyprctl -j monitors | yq '.[] | .id') # Get monitor IDs
num_windows_current_workspace=$(hyprctl -j activeworkspace | yq '.windows')
specialwsarr=$(hyprctl workspaces -j | yq --raw-output '.[] | .name | match("special.*") | .string')
currentappname=$(hyprctl activewindow)
scratchname=$(hyprctl activewindow -j | yq --raw-output --join-output '.initialTitle, .pid')

for m in ${specialwsarr[@]}; do
  echo $m
done

