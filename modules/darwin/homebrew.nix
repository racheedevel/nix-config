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
      "lazygit"
      "glab"
      "gh"  
    ];

    # AppStore Apps
    masApps = [];
    # Apps
    casks = [];
    # WhaleBrews
    whalebrews = [];
    # Taps
    taps = [];
  };
}
