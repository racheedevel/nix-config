{ config, pkgs, ... }:

{
  xdg.configFile."hypr" = {
    source = ../../configs/hypr;
    recursive = true;
    force = true;
  };

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
