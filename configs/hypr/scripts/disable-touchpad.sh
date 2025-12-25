#!/bin/sh
HYPRLAND_DEVICE="pixa3854:00-093a:0274-touchpad"

export STATUS_FILE="$HOME/.settings/touchpad_status"

enable_touchpad() {
  printf "true" >"$STATUS_FILE"

  hyprctl notify 1 1000 0 "Enabling Touchpad"

  hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" true
}

disable_touchpad() {
  printf "false" >"$STATUS_FILE"

  hyprctl notify 1 1000 0 "Disabling Touchpad"

  hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" false
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ "$(cat $STATUS_FILE)" = "true" ]; then
    disable_touchpad
  elif [ "$(cat $STATUS_FILE)" = "false" ]; then
    enable_touchpad
  fi
fi
