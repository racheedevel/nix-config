{ lib, config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".zsh";
    enableVteIntegration = true;
    autocd = true;


    antidote = {
      enable = true;
      plugins = [
        "sindresorhus/pure"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions kind:fpath path:src"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
      useFriendlyNames = true;
    };
    shellAliases = {
      ll = "eza -la";
      ls = "eza";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch --flake ~/.os#rachee-fw";
      update = "nix flake update ~/.os";
    };

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
  ];

  # home.file.".zsh" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/configs/zsh";
  #     recursive = false;
  # };

  home.file.".secrets" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/rachee/.os/secrets";
  };

  home.sessionVariables = {
      ZDOTDIR = ".zsh";
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

  xdg.configFile."starship.toml" = {
    source = ../../configs/starship/starship.toml;
    recursive = true;
    force = true;
  };

}
