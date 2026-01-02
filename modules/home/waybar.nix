
{ config, pkgs, ... }:

{

  # Hyprland-related user packages
  home.packages = with pkgs; [
    waybar
  ];
}
