{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      font-awesome
      hack-font
      iosevka
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Iosevka"
          "Hack"
          "JetBrains Mono"
        ];
        sansSerif = [
          "Roboto"
          "DejaVu Sans"
        ];
        serif = [ "DejaVu Serif" ];
      };
    };
  };
}
