{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      ".direnv/"
      ".envrc"
      "target/"
      ".env.local"
      "dist"
      ".env"
      "dct.yml"
      "dct.yaml"
      "_local/"
      ".beads/"
      ".claude/"
      ".claude.json"
      "CLAUDE.md"
      "AGENTS.md"
      "plan/"
    ];
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
    glab
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
      disableStartupPopups = false;
    };
  };

  programs = {
    gh.enable = true;
    git-cliff.enable = true;
    gh-dash.enable = true;
    jujutsu.enable = true;
  };
}
