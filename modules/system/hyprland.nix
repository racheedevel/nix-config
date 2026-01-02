{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
        hyprland = {
          default = [
            "gtk"
            "hyprland"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
        wlroots = {};
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-termfilechooser
      ];
    };
  };
  

  services.displayManager.ly.enable = true;

  security.pam.services.ly.rules.auth.fprintd.enable = lib.mkForce false;

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.sessionVariables.XDG_CURRENT_DESKTOP = "Hyprland:X-NIXOS-SYSTEMD-AWARE";

  # environment.etc."wayland-sessions/hyprland.desktop".text = ''
  #   [Desktop Entry]
  #   Name=Hyprland
  #   Exec=Hyprland
  #   Type=Application
  # '';
}
