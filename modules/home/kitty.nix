{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka";
      font_size = 12;
      background_opacity = "0.9";
      
      # Catppuccin-ish colors
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      cursor = "#F5E0DC";
      
      window_padding_width = 8;
      confirm_os_window_close = 0;
    };
  };
}
