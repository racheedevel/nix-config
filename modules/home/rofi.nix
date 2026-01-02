{ config, pkgs, ... }:

{

  # Rofi install
  home.packages = with pkgs; [
    rofi
  ];
}
