{ config, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
    ./kubernetes.nix
    ./neovim.nix
    ./rofi.nix
    ./shell.nix
    ./theme.nix
    ./waybar.nix
    ./yazi.nix
    ./zathura.nix
    ./xdg-directories.nix
  ];

  home.username = "rachee";
  home.homeDirectory = "/home/rachee";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/rachee/.os";
  };

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
