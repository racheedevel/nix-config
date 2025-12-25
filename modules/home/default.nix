{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./neovim.nix
    ./kitty.nix
    ./git.nix
    ./hyprland.nix
    ./rofi.nix
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
    python3

    # Day-to-day
    chromium

    # Fonts
    iosevka
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
