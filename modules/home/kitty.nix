{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka Semibold";
      size = 14.0;
    };
    settings = {
      # Font
      font_family = "Iosevka Semibold";
      bold_font = "Iosevka Bold";
      italic_font = "Iosevka Italic";
      bold_italic_font = "Iosevka Bold Italic";
      # bold_font = "auto";
      # italic_font = "auto";
      # bold_italic_font = "auto";
      # font_size = 14;

      # Theming
      background_opacity = "1";
      cursor = "#e2e2e3";
      cursor_text_color = "#222327";
      cursor_shape = "block";
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;

      # Scrolling
      scrollback_lines = 5000;
      scrollback_pager = "nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -";
      scrollback_pager_history_size = 10;
      scrollback_fill_enlarged_window = "no";
      touch_scroll_multiplier = 1.5;

      # Mouse
      mouse_hide_wait = 3.0;
      url_color = "#9ed072";
      url_style = "dotted";
      open_url_with = "chromium";
      url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh";
      detect_urls = "yes";
      copy_on_select = "clipboard";
      paste_actions = "quote-urls-at-prompt";
      strip_trailing_spaces = "smart";
      select_by_word_characters = "@-./_~?&=%+#:";
      focus_follows_mouse = "no";
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "arrow";
      pointer_shape_when_dragging = "arrow";

      # ── Bell ──
      enable_audio_bell = "no";

      # ── Window Layout ──
      enabled_layouts = "splits,stack,tall,fat,horizontal";
      draw_minimal_borders = "no";
      window_margin_width = 0;
      window_padding_width = 0;
      placement_strategy = "center";
      inactive_text_alpha = "1.0";
      hide_window_decorations = "yes";
      window_logo_position = "bottom-left";
      window_logo_alpha = "0.5";
      resize_in_steps = "no";
      visual_window_select_characters = "QWERTY123456";
      confirm_os_window_close = 0;
      window_resize_step_cells = 10;
      window_resize_step_lines = 5;

      # ── Tab Bar ──
      tab_bar_edge = "bottom";
      tab_bar_margin_width = "0.0";
      tab_bar_margin_height = "0.0 0.0";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      tab_bar_align = "left";
      tab_bar_min_tabs = 1;
      tab_switch_strategy = "left";
      tab_separator = " ┇";
      tab_title_max_length = 0;
      active_tab_font_style = "bold";
      bell_on_tab = "no";

      # Tab title: show index + directory (+ command if not shell)
      tab_title_template = "{index} {tab.active_wd.split('/')[-1] if tab.active_exe == '' or tab.active_exe == 'zsh' else tab.active_wd.split('/')[-1].lstrip(' ').lstrip('.') + ': ' + tab.active_exe.replace('.', '').replace(' ', '')}";

      # # ── Colors (Ayu-inspired from your tmux) ──
      # foreground = "#BFBDB6";
      # background = "#0B0E14";
      # dim_opacity = "0.6";
      # selection_foreground = "#0B0E14";
      # selection_background = "#39BAE6";

      # # Tab colors (Ayu)
      # active_tab_foreground = "#0B0E14";
      active_tab_background = "#AAD94C";
      # inactive_tab_foreground = "#BFBDB6";
      # inactive_tab_background = "#0B0E14";
      # tab_bar_background = "#0B0E14";
      # tab_bar_margin_color = "#0B0E14";

      # ── Advanced ──
      shell = "zsh";
      editor = "nvim";
      allow_remote_control = "socket-only";
      listen_on = "unix:@kittycontrol";
      remote_control_password = "catctrl";
      clipboard_control = "write-primary read-primary-ask";
      clipboard_max_size = 512;
      file_transfer_confirmation_bypass = "catctrl";
      shell_integration = "enabled";
      clone_source_strategies = "venv,conda,env_var,path";

      # ── Keyboard ──
      kitty_mod = "ctrl";
      clear_all_shortcuts = "yes";
    };
    keybindings = {
      # ── Clipboard ──
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "kitty_mod+space>y" = "new_window nvim @selection";

      # ── Scrolling ──
      "shift+up" = "scroll_line_up";
      "shift+down" = "scroll_line_down";
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "shift+home" = "scroll_home";
      "shift+end" = "scroll_end";
      "shift+left" = "scroll_to_prompt -1";
      "shift+right" = "scroll_to_prompt 1";
      "kitty_mod+space>h" = "show_scrollback";
      "kitty_mod+space>[" = "show_scrollback";

      # ── Splits (tmux-style) ──
      "kitty_mod+space>|" = "launch --location=vsplit --cwd=current";
      "kitty_mod+space>-" = "launch --location=hsplit --cwd=current";
      "kitty_mod+space>_" = "launch --location=hsplit --cwd=current";

      # ── Pane Navigation (C-Arrow like tmux) ──
      "ctrl+left" = "neighboring_window left";
      "ctrl+right" = "neighboring_window right";
      "ctrl+up" = "neighboring_window up";
      "ctrl+down" = "neighboring_window down";

      # ── Pane Resizing ──
      "ctrl+shift+left" = "resize_window narrower 3";
      "ctrl+shift+right" = "resize_window wider 3";
      "ctrl+shift+up" = "resize_window taller 3";
      "ctrl+shift+down" = "resize_window shorter 3";

      # ── Zoom (like tmux prefix+z) ──
      "kitty_mod+space>z" = "toggle_layout stack";

      # ── Window Management ──
      "kitty_mod+space>n" = "new_window";
      "kitty_mod+space>shift+n" = "launch --cwd=current";
      "kitty_mod+space>x" = "close_window";
      "kitty_mod+space>f" = "move_window_forward";
      "kitty_mod+space>shift+f" = "move_window_backward";
      "kitty_mod+space>w" = "focus_visible_window";
      "kitty_mod+space>s" = "swap_with_window";

      # ── Tab Management ──
      "kitty_mod+space>enter" = "new_tab";
      "kitty_mod+space>shift+enter" = "new_tab_with_cwd";
      "kitty_mod+space>ctrl+shift+enter" = "new_tab_with_cwd nvim";
      # "kitty_mod+space>]" = "next_tab";
      # "kitty_mod+space>[" = "previous_tab";
      "kitty_mod+space>q" = "close_tab";
      "kitty_mod+space>," = "set_tab_title";
      "kitty_mod+space>." = "move_tab_forward";
      "kitty_mod+space>shift+." = "move_tab_backward";
      "kitty_mod+space>d" = "detach_window new-tab";
      "kitty_mod+space>shift+d" = "detach_window";

      # F-keys for tab switching
      "f1" = "goto_tab 1";
      "f2" = "goto_tab 2";
      "f3" = "goto_tab 3";
      "f4" = "goto_tab 4";
      "f5" = "goto_tab 5";
      "f6" = "goto_tab 6";
      "f7" = "goto_tab 7";
      "f8" = "goto_tab 8";
      "f9" = "goto_tab 9";
      "f10" = "goto_tab 10";

      # ── Popups (overlay windows - like tmux popups) ──
      "kitty_mod+space>g" = "launch --type=overlay --cwd=current lazygit";
      "kitty_mod+space>escape" = "launch --type=overlay --cwd=current";
      "kitty_mod+space>b" = "launch --type=overlay btop";

      # ── Quick Actions ──
      "kitty_mod+space>v" = "launch --type=tab --cwd=current nvim .";
      "kitty_mod+space>e" = "send_text normal nvim .\\r";

      # ── Font Sizes ──
      "ctrl+shift+equal" = "change_font_size current +1.0";
      "ctrl+shift+minus" = "change_font_size current -1.0";
      "ctrl+shift+0" = "change_font_size all 0";

      # ── URL Hints ──
      "kitty_mod+space>u" = "kitten hints --hints-offset=0";

      # ── Misc ──
      "kitty_mod+space>?" = "show_kitty_doc overview";
      "kitty_mod+space>c" = "edit_config_file";
      "kitty_mod+space>ctrl+escape" = "kitty_shell overlay";
      "kitty_mod+space>t" = "set_background_opacity 1";
      "kitty_mod+space>ctrl+t" = "set_background_opacity 0.5";
      "kitty_mod+space>delete" = "clear_terminal reset all";
      "kitty_mod+space>l" = "clear_terminal scroll active";
      "kitty_mod+space>r" = "load_config_file";
      "kitty_mod+space>shift+r" = "debug_config";
    };

    extraConfig = ''
      # Action aliases
      action_alias launch_tab launch --type=tab --cwd=current
      action_alias hints kitten hints --hints-offset=0
      kitten_alias ssh kitten_ssh

      # Mouse mappings
      mouse_map ctrl+left release grabbed,ungrabbed mouse_handle_click link
      mouse_map middle release ungrabbed paste_from_selection
      mouse_map left press ungrabbed mouse_selection normal
      mouse_map ctrl+alt+left press ungrabbed mouse_selection rectangle
      mouse_map left doublepress ungrabbed mouse_selection word
      mouse_map left triplepress ungrabbed mouse_selection line

      # Ayu dark color palette (for reference/extensions)
      # These are available via settings but documenting here:
      # @ayu_bg      #0B0E14
      # @ayu_fg      #BFBDB6
      # @ayu_ui      #565B66
      # @ayu_accent  #E6B450
      # @ayu_tag     #39BAE6
      # @ayu_func    #FFB454
      # @ayu_string  #AAD94C
      # @ayu_keyword #FF8F40
      # @ayu_error   #D95757

      # # Terminal colors (Ayu dark)
      # color0  #0B0E14
      # color1  #D95757
      # color2  #AAD94C
      # color3  #E6B450
      # color4  #39BAE6
      # color5  #D2A6FF
      # color6  #95E6CB
      # color7  #BFBDB6
      # color8  #565B66
      # color9  #F07178
      # color10 #C2D94C
      # color11 #FFB454
      # color12 #59C2FF
      # color13 #D2A6FF
      # color14 #95E6CB
      # color15 #F8F8F2

      # # Pane borders (Ayu)
      # active_border_color   #E6B450
      # inactive_border_color #565B66

      foreground            #f8f8f2
      background            #282a36
      selection_foreground  #ffffff
      selection_background  #44475a
      url_color #8be9fd
      color0  #21222c
      color8  #6272a4
      color1  #ff5555
      color9  #ff6e6e
      color2  #50fa7b
      color10 #69ff94
      color3  #f1fa8c
      color11 #ffffa5
      color4  #bd93f9
      color12 #d6acff
      color5  #ff79c6
      color13 #ff92df
      color6  #8be9fd
      color14 #a4ffff
      color7  #f8f8f2
      color15 #ffffff
      cursor            #f8f8f2
      cursor_text_color background
      # active_tab_foreground   #282a36
      # active_tab_background   #f8f8f2
      inactive_tab_foreground #282a36
      inactive_tab_background #6272a4
      mark1_foreground #282a36
      mark1_background #ff5555

      # Mark colors
      # mark1_foreground #0B0E14
      # mark1_background #39BAE6
      mark2_foreground #0B0E14
      mark2_background #AAD94C
      mark3_foreground #0B0E14
      mark3_background #D95757
    '';

  };

  xdg.configFile."kitty/float.conf".text = ''
    # Override config for quick-access-terminal
    # Minimal kitty config for floating ephemeral windows

    # Inherit font from main config isn't possible, so set it
    font_family      JetBrainsMono Nerd Font
    font_size        14.0

    # No tab bar
    tab_bar_min_tabs 9999

    # Behavior
    enable_audio_bell no
    shell_integration enabled

    # Minimal look
    window_padding_width 8
    hide_window_decorations yes
    confirm_os_window_close 0
    background_opacity 0.95

    # Only essentials
    map ctrl+c copy_and_clear_or_interrupt
    map ctrl+v paste_from_clipboard
    map ctrl+shift+c copy_to_clipboard
    map ctrl+shift+v paste_from_clipboard
    map shift+up scroll_line_up
    map shift+down scroll_line_down
    map shift+page_up scroll_page_up
    map shift+page_down scroll_page_down
    map ctrl+q close_window


    foreground            #f8f8f2
    background            #282a36
    selection_foreground  #ffffff
    selection_background  #44475a
    url_color #8be9fd
    color0  #21222c
    color8  #6272a4
    color1  #ff5555
    color9  #ff6e6e
    color2  #50fa7b
    color10 #69ff94
    color3  #f1fa8c
    color11 #ffffa5
    color4  #bd93f9
    color12 #d6acff
    color5  #ff79c6
    color13 #ff92df
    color6  #8be9fd
    color14 #a4ffff
    color7  #f8f8f2
    color15 #ffffff
    cursor            #f8f8f2
    cursor_text_color background
    # active_tab_foreground   #282a36
    # active_tab_background   #f8f8f2
    inactive_tab_foreground #282a36
    inactive_tab_background #6272a4
    mark1_foreground #282a36
    mark1_background #ff5555

    # Mark colors
    # mark1_foreground #0B0E14
    # mark1_background #39BAE6
    mark2_foreground #0B0E14
    mark2_background #AAD94C
    mark3_foreground #0B0E14
    mark3_background #D95757
  '';

  home.packages = with pkgs; [
    lazygit
    btop
    (pkgs.writeShellScriptBin "kf" ''
      exec kitty --class=kitty-float --config="$HOME/.config/kitty/float.conf" "$@"
    '')
  ];
}
