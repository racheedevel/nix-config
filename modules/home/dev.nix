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

    home.file.".vimrc" = {
      source = ../../configs/vim/.vimrc;
    };

    home.file.".viminfo" = {
      source = ../../configs/vim/.viminfo;
    };

    home.file.".vim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/configs/vim/.vim";
    };

    programs.gemini-cli = {
      enable = true;
    };

    services.yubikey-agent = {
      enable = true;
    };
}
