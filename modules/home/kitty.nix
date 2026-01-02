{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      mode = null;
    };

    extraConfig = ''
      include config.conf
    '';

  };

  home.packages = with pkgs; [
    lazygit
    btop
    (pkgs.writeShellScriptBin "kf" ''
      exec kitty --class=kitty-float --config="$HOME/.config/kitty/float.conf" "$@"
    '')
  ];

}
