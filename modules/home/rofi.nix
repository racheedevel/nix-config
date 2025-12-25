{ config, pkgs, ... }:

{
  xdg.configFile."rofi" = {
    source = ../../configs/rofi;
    recursive = true;
    force = true;
  };

  # Rofi install
  home.packages = with pkgs; [
    rofi
  ];
}
