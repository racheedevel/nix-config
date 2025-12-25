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

  home.packages = with pkgs; [
    github-cli
    lazygit
  ];
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };

  programs.lazygit = {
    enable = true;
    shellWrapperName = "lg";
    enableZshIntegration = true;
    settings = {
      gui.theme = {
        activeBorderColor = [
          "green"
          "bold"
        ];
      };
      gui.spinner.frames = [
        "("
        "‿"
        ")"
        "⁀"
      ];
      gui.spinner.rate = 150;
      git = {
        overrideGpg = true;
        autoFetch = true;
      };
      notARepository = "skip";
      promptToReturnFromSubprocess = false;
      confirmOnQuit = false;
      disableStartupPopups = true;
    };
  };
}
