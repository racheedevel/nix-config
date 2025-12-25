#!/usr/bin/env bash
wallpaper_path=$(cat ~/.settings/current_wallpaper)

# if [[ -f $wallpaper_path ]]; then
#   swaylock -f -i "$wallpaper_path" --clock --datestr "%d.%m.%Y" --indicator --indicator-radius 200 --indicator-thickness 10 --effect-blur 30x5 --effect-vignette 0.5:0.5 --ring-color fab387 --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --grace 0
#
# else

swaylock -f \
  -c 1c2433 \
  --clock \ 
--datestr "%d.%m.%Y" \
  --indicator \
  --indicator-radius 200 \
  --indicator-thickness 10 \
  --ring-color 9bdead \
  --ring-clear-color b78aff \
  --ring-ver-color b78aff \
  --ring-wrong-color b78aff \
  --key-hl-color 3cec85 \
  --line-color 1c2433 \
  --line-clear-color 232b3a \
  --line-ver-color 232b3a \
  --line-wrong-color 232b3a \
  --inside-color 232b3a \
  --inside-clear-color f38cec \
  --inside-wrong-color FF738A \
  --inside-ver-color 6da4cd \
  --separator-color 00000000 \
  --font "Monaspace Neon" \
  --text-color 9bdead \
  --text-clear-color 1c2433 \
  --text-ver-color 1c2433 \
  --text-wrong-color 232b3a \
  --effect-blur 30x5 \
  --effect-vignette 0.5:0.5 \
  --grace 2 \
  --grace 0
# fi
