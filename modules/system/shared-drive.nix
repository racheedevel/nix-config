{ config, pkgs, ... }:

{
  # Keyfile - managed outside nix store for security
  environment.etc."crypttab".text = ''
    shared UUID=8c8c35ea-5ecf-4599-b84c-4690cacae191 /etc/secrets/shared.key luks
  '';

  fileSystems."/shared/securely" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@securely"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/shared/github" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@github"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/shared/gitlab" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@gitlab"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/shared/dev" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@dev"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/shared/resources" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@resources"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/shared/secrets" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@secrets"
      "compress=zstd"
      "noatime"
      "nofail"
    ];
  };

  fileSystems."/shared/config" = {
    device = "/dev/mapper/shared";
    fsType = "btrfs";
    options = [
      "subvol=@config"
      "compress=zstd"
      "noatime"
      "nofail"
      "x-systemd.before=display-manager.service"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /shared 0755 rachee users -"
    "d /shared/securely 0755 rachee users -"
    "d /shared/github 0755 rachee users -"
    "d /shared/gitlab 0755 rachee users -"
    "d /shared/dev 0755 rachee users -"
    "d /shared/resources 0755 rachee users -"
    "d /shared/config 0755 rachee users -"
    "L+ /home/rachee/projects/work - - - - /shared/securely"
    "L+ /home/rachee/projects/github - - - - /shared/github"
    "L+ /home/rachee/projects/gitlab - - - - /shared/gitlab"
    "L+ /home/rachee/projects/dev - - - - /shared/dev"
    "L+ /home/rachee/shared/config - - - - /shared/config"
    "L+ /home/rachee/shared/secrets - - - - /shared/secrets"
  ];

  system.activationScripts.projectsDir = ''
    mkdir -p /shared/{secrets,securely,github,gitlab,dev,config,resources}
    chown rachee:users /shared
  '';
}
