
{ config, pkgs, ... }:

{
  xdg.configFile."waybar" = {
    source = ../../configs/waybar;
    recursive = true;
    force = true;
  };

  # Hyprland-related user packages
  home.packages = with pkgs; [
    waybar
  ];
}
