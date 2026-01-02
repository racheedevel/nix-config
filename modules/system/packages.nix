{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core
    git
    curl
    wget
    
    # Editors (neovim handled by home-manager)
    vim
    
    # Wayland/Hyprland tools
    waybar
    rofi
    dunst
    wl-clipboard
    grim
    slurp
    nwg-look
    
    # System tools
    htop
    btop
    ripgrep
    fd
    eza
    bat
    unzip
    psmisc # killall / fuser / pstree / etc
    antidote
    zsh-defer
    go
    rbenv
    atuin
    xdg-desktop-portal-termfilechooser
  ];

  programs.firefox.enable = true;
}
