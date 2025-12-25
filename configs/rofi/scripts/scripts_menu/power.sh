#!/usr/bin/env bash

# Define options with emoji/icons
options=(
  "🔒 Lock"
  "⏻ Shutdown"
  "🔁 Reboot"
  "🚪 Logout"
  "❌ Cancel"
)

# Show menu
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "Power Menu")

# Handle choice
case "$choice" in
  "🔒 Lock")
    swaylock ;;
  "⏻ Shutdown")
    sudo shutdown -P now ;;
  "🔁 Reboot")
    sudo reboot ;;
  "🚪 Logout")
    loginctl terminate-session "$XDG_SESSION_ID" ;;
  *)
    exit 0 ;;
esac
