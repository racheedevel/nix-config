{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
    ./neovim.nix
    ./rofi.nix
    ./shell.nix
    ./theme.nix
    ./waybar.nix
  ];

  home.username = "rachee";
  home.homeDirectory = "/home/rachee";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Extra packages managed at user level
  home.packages = with pkgs; [
    # Dev tools
    rustup
    bun
    nixfmt-rfc-style
    python315
    uv
    zig
    ruby
    nodejs

    # Day-to-day
    chromium

    # Fonts
    iosevka
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
