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
    ../../modules/system/docker.nix
    ../../modules/system/keyring.nix
    ../../modules/system/shared-drive.nix
  ];

  # Boot
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
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
    initialPassword = "changeme";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };
  users.users.root = {
    home = "/root";
  };

  security.sudo.enable = false;
  security.sudo-rs = {
      enable = true;
      execWheelOnly = true;
  };

  # Services
  services.userborn.enable = true;
  services.libinput.enable = true;
  services.fprintd.enable = true;

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

  nix.settings.trusted-users = [ "root" "rachee" ];
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    ZDOTDIR = "$HOME/.zsh";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "25.11";
}
