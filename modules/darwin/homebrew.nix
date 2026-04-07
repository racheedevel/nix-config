{
  pkgs,
  self,
  ...
}:

{
  # Darwin Homebrew Module
  homebrew = {
    enable = true;
    # Tools
    brews = [
	  "atuin"
      "vivid"
      "antidote"
      "zoxide"
      "eza"
      "fnm"
      "just"
      "jujutsu"
      "bat"
      "kubectl"
      "talosctl"
      "kustomize"
      "kubectx"
      "hcloud"
      "direnv"
      "lazygit"
      "glab"
      "bun"
      "gh"  
    ];

    # AppStore Apps
    # masApps = [];
    # Apps
    # casks = [];
    # WhaleBrews
    # whalebrews = [];
    # Taps
    taps = [
      "oven-sh/bun"
    ];
  };
}
