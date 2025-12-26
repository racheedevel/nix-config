{ config, pkgs, ... }:

{
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    programs.gemini-cli = {
      enable = true;
    };

    services.yubikey-agent = {
      enable = true;
    };
}
