{ config, pkgs, ... }:

{
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      devenv
    ];

    programs.gemini-cli = {
      enable = true;
    };

    services.yubikey-agent = {
      enable = true;
    };
}
