{ config, pkgs, ... }:

{
  # Keyfile - managed outside nix store for security
  boot.initrd.luks.devices."shared" = {
    device = /dev/disk/by-uuid/8c8c35ea-5ecf-4599-b84c-4690cacae191;
    keyFile = /etc/secrets/shared.key;
    preLVM = false;
  };

  fileSystems."/shared/securely" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@securely"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/shared/github" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@github"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/shared/gitlab" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@gitlab"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/shared/dev" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@dev"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/shared/resources" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@resources"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/shared/config" = {
    device = /dev/mapper/shared;
    fsType = "btrfs";
    options = [
      "subvol=@config"
      "compress=zstd"
      "noatime"
    ];
  };

  systemd.tmpfiles.rules = [
    "L+ /home/rachee/projects/work - - - - /shared/securely"
    "L+ /home/rachee/projects/github - - - - /shared/github"
    "L+ /home/rachee/projects/gitlab - - - - /shared/gitlab"
    "L+ /home/rachee/projects/dev - - - - /shared/dev"
    "L+ /home/rachee/shared/config - - - - /shared/config"
  ];

  system.activationScripts.projectsDir = ''
    mkdir -p /shared/{securely,github,gitlab,dev,config,resources}
    chown rachee:users /shared
  '';
}
