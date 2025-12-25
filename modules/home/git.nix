{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {

    user.name = "racheedevel";
    user.email = "git@rachee.dev";

    init.defaultBranch = "main";
    pull.rebase = true;
    push.autoSetupRemote = true;

    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };
}
