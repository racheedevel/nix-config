{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    devenv
    vim-full
  ];

  #programs.gemini-cli = {
  #  enable = true;
  #};

  services.yubikey-agent = {
    enable = true;
  };
}
