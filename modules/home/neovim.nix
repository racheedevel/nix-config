{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    # vimAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rust-analyzer
      nil
      ripgrep
      fd
      gcc
    ];
  };

  # Mutable symlink - points directly to your repo, not nix store
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/configs/nvim";
}
