{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;

    enableOnBoot = false;

    storageDriver = "btrfs";
    daemon.settings = {
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };

  users.users.rachee.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
    docker-credential-helpers
    lazydocker
    dive
  ];
}
