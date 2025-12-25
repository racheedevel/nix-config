{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/packages.nix
    ../../modules/system/1password.nix
    ../../modules/system/gpu.nix
    ../../modules/system/fonts.nix
  ];

  # Boot
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."nixcrypt".device =
    "/dev/disk/by-uuid/278df479-352c-4eef-a4b8-b60a8ab6d39c";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Network
  networking.hostName = "rachee-fw";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  programs.zsh.enable = true;
  users.users.rachee = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  security.sudo.enable = false;
  security.sudo-rs = {
      enable = true;
      execWheelOnly = true;
  };

  # Services
  services.userborn.enable = true;
  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    ZDOTDIR = "$HOME/.zsh";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "25.11";
}
