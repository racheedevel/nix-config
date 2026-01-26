{
  pkgs,
  self,
  ...
}:

{
  # List packages installed in system profile.
  environment.systemPackages = [
    pkgs.vim
  ];



  networking = {
    dns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
