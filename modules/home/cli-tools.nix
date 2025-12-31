{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      procs
      duf
      httpie
    ];
}
