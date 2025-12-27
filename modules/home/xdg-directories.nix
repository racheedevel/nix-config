{config, ...}:

{
  xdg.userDirs = {
    enable = true;
    documents = "${config.home.homeDirectory}/docs";
    download = "${config.home.homeDirectory}/xdg/dl";
    desktop = "${config.home.homeDirectory}/xdg/desktop";
    music = "${config.home.homeDirectory}/xdg/music";
    pictures = "${config.home.homeDirectory}/xdg/pictures";
    publicShare = "${config.home.homeDirectory}/xdg/share";
    templates = "${config.home.homeDirectory}/xdg/templates";
    videos = "${config.home.homeDirectory}/xdg/videos";
    # createDirectories = true;
  };
}
