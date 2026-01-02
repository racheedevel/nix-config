{ config, pkgs, ... }:

{

  # Hyprland-related user packages
  home.packages = with pkgs; [
    rofi
    dunst
    wl-clipboard
    grim
    slurp
    swaylock-fancy
    hyprpaper
    hypridle
    hyprlock
  ];
}
