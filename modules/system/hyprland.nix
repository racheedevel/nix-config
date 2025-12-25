{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.displayManager.ly.enable = true;
  security.polkit.enable = true;
  hardware.graphics.enable = true;

  environment.etc."wayland-sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Exec=Hyprland
    Type=Application
  '';
}
