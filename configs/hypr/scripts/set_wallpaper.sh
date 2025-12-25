wallpapers=()

for wpres in $(find /usr/share/wallpapers/cachyos-wallpapers/); do
  if [[ -f $wpres ]]; then
    echo $wpres
    wallpapers+=("${wpres}")
  fi
done
wpselection=$(echo "${wallpapers[@]}" | rofi -dmenu -sep " " -p "wallpaper" -keep-right)
rm -f ~/.settings/current_wallpaper
echo "${wpselection}" >>~/.settings/current_wallpaper
hyprctl hyprpaper preload ${wpselection}
hyprctl hyprpaper reload ,"${wpselection}"
