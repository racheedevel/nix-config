{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland.enable = true;

  services.displayManager.ly.enable = true;

  security.pam.services.ly.rules.auth.fprintd.enable = lib.mkForce false;

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.etc."wayland-sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Exec=Hyprland
    Type=Application
  '';
}
