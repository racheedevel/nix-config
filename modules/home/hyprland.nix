{ config, pkgs, ... }:

{
  xdg = {
    configFile = {
      "hypr" = {
        source = ../../configs/hypr;
        recursive = true;
        force = true;
      };
      "xdg-desktop-portal-termfilechooser" = {
        force = true;
        source = ../../configs/termfilechooser;
        recursive = true;
      };
    };

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

  wayland.windowManager.hyprland.systemd.enable = false;

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
