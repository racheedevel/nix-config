{ config, pkgs, ... }:

{
  # programs.zsh = {
  #   enable = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;

  #   shellAliases = {
  #     ll = "eza -la";
  #     ls = "eza";
  #     cat = "bat";
  #     rebuild = "sudo nixos-rebuild switch --flake ~/.os#rachee-fw";
  #     update = "nix flake update ~/.os";
  #   };

  #   initContent = ''
  #     # Any extra zsh config here
  #   '';
  # };

  home.packages = with pkgs; [
    antidote
    zsh
    eza
    bat
    fzf
    zoxide
    lazygit
  ];

  home.file.".zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/configs/zsh";
      recursive = false;
  };

  home.file.".secrets" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/secrets";
  };

  home.sessionVariables = {
      ZDOTDIR = "$HOME/.zsh";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
