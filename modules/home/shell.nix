{
  lib,
  config,
  pkgs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = config.home.homeDirectory + "/.zsh";
    enableVteIntegration = true;
    autocd = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions kind:fpath path:src"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
      useFriendlyNames = true;
    };

    shellAliases = {
      ls = "eza --group-directories-first --color -a --icons -l -o --show-symlinks --dereference";
      ll = "eza --group-directories-first --color -a --icons -l -o";
      ts = "tailscale";
      rse = "nvim Cargo.toml";
      glabs = "GITLAB_HOST=git.securely.ai glab";
      glabp = "GITLAB_HOST=gitlab.com glab";
      lab = "GITLAB_HOST=git.rachee.dev glab";
      venv = "source ./.*/*/activate";
      t = "task -g";
      ce = "nvim ~/.os";
      grep = "rg --color=auto";
      k = "kubectl";
      h = "helm";
      fx = "flux";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch --flake ~/.os#rachee-fw";
      update = "nix flake update --flake ~/.os";
      dcu = "docker compose up --build -d";
      dcd = "docker compose down";
      dcl = "docker compose logs -f";
      dcr = "docker compose restart";
      dcp = "docker compose ps";
      dcs = "docker compose stop -t 0";
      sctl = "systemctl --user";
    };

    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)";
      G = "| grep";
      WORK = "cd projects securely";
      GH = "cd projects github";
      GL = "cd projects gitlab";
      GG = "cd projects dev";
      CFG = "cd shared config";
      SCFG = "cd shared secrets";
    };

    sessionVariables = {
      LISTMAX = 1500;
      ENABLE_CORRECTION = "false";

      COMPLETION_WAITING_DOTS = "false";
      # Ignore some commands from history
      HISTIGNORE = "&:ls:[bf]g:c:clear:history:exit:q:pwd:* --help:kubectl create secret:* -h";
      # Timestamp format for history records
      HIST_STAMPS = "mm/dd/yyyy";
      # Change data path to .local/share
      XDG_DATA_HOME = "$HOME/.local/share";
      # Simplifies editing zsh sourced files
      ZPROF = "$ZDOTDIR/.profile";
      # 1Password
      OP_BIOMETRIC_UNLOCK_ENABLED = true;
      # Wtfis network/ip/asn sniffer
      WTFIS_DEFAULTS = "-u -1";
      # Minimal style adjustment for qt apps
      QT_QPA_PLATFORMTHEME = "qt5ct";
      # History substring search remove duplicates
      KUBECONFIG = "$HOME/.kube/kubeconfig";
      FOCUSRITE_MIC = "alsa_input.usb-Focusrite_Scarlett_Solo_USB_Y7ZY0HB497A3FD-00.HiFi__Mic1__source";
      AIRPODS = "bluez_output.90_62_3F_5A_23_A4.1";
      UV_PREVIEW = 1;
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
      BROWSER = "chromium";
    };

    # profileExtra = ''
    #   if uwsm check may-start && uwsm select; then
    #       exec uwsm start default
    #   fi
    # '';

    initContent = ''
      unsetopt menu_complete
      unsetopt auto_menu
      setopt auto_list
      setopt list_ambiguous
      unsetopt always_last_prompt
      setopt autocd pushdignoredups interactivecomments
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' auto-list yes
      zstyle ':completion:*' use-compctl false

      bindkey -e
      bindkey -r '^I'
      bindkey '^I' expand-or-complete
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char


      bindkey "^[H" beginning-of-line
      bindkey "^[L" end-of-line
      bindkey "^[J" down-line
      bindkey "^[K" up-line
      # Alt+Backspace
      bindkey '^[^?' backward-delete-word 
      # Alt+Delete
      bindkey '^[^[[3~' delete-word
      # Delete
      bindkey '^[[3~' delete-char
      # Alt+h: backward-word
      bindkey '^[h' backward-word

      # Alt+l: forward-word
      bindkey '^[l' forward-word

      # Alt+k: beginning-of-line
      bindkey '^[k' beginning-of-line

      # Alt+j: end-of-line
      bindkey '^[j' end-of-line

      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down


      typeset -gU fpath
      _zfunc="''${ZDOTDIR:-$HOME}/.zfunc"
      fpath=("$_zfunc" $fpath)

      # setup plugins
      #_plugins="''${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"
      #[[ -r "$_plugins" ]] && source "$_plugins"

      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      # actually load completions
      autoload -Uz compinit
      _compdump="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-''${ZSH_VERSION}"
      compinit -C -d "$_compdump"
      if [[ -n {$ZDOTDIR:-$HOME} ]]; then
          zcompdump=''${ZDOTDIR:-$HOME}/.zcompdump
      fi


      gencompletion() {
          local name=$1; shift
          command -v "$name" >/dev/null || return 0
          eval "$*" > "$_zfunc/_$name" 2>/dev/null || return 0
      }

      rb_init() {
          eval "$(rbenv init -)"
      }

      nvm_init() {
          source /usr/share/nvm/init-nvm.sh
      }

      lg()
      {
          export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

          lazygit "$@"

          if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
                  cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
                  rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
          fi
      }

        [[ -f ~/.secrets/env-secrets.sh ]] && source ~/.secrets/env-secrets.sh
    '';
  };

  home.packages = with pkgs; [
    antidote
    zsh
    eza
    bat
    fzf
    zoxide
    lazygit
    figlet
    jp2a
  ];

  home.sessionVariables = {
    ZDOTDIR = config.home.homeDirectory + "/.zsh";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    forceOverwriteSettings = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableTransience = true;
  };

}
