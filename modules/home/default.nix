{ config, pkgs, ... }:

{
  imports = [
    ./cli-tools.nix
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
    ./xdg-directories.nix
    ./yazi.nix
    ./zathura.nix
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
    optnix

    # Fonts
    iosevka
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
