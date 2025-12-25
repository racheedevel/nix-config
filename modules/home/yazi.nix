{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        show_hidden = true;
      };

      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };

    initLua = ''

    '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "<C-x>";
          run = "shell -- dragon -x -i -T \"$0\"";
        }
      ];
    };
  };
}
