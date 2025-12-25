# source $ZDOTDIR/antidote/antidote.zsh
if command -v antidote &>/dev/null; then
    source $(antidote init)
fi

# disable basic annoying shit
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


for profile_script in "$ZDOTDIR"/.profile/*
do
    source "$profile_script"
done


zle -N copy_current_command_to_clipboard # .profile/func.sh
bindkey "^Y" copy_current_command_to_clipboard

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X" edit-command-line

# setup completion fpath
typeset -gU fpath
_zfunc="${ZDOTDIR:-$HOME}/.zfunc"
fpath=("$_zfunc" $fpath)

# setup plugins
_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"
[[ -r "$_plugins" ]] && source "$_plugins"

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# actually load completions
autoload -Uz compinit
_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
compinit -C -d "$_compdump"
if [[ -n {$ZDOTDIR:-$HOME} ]]; then
    zcompdump=${ZDOTDIR:-$HOME}/.zcompdump
fi
[[ -d $ZDOTDIR ]] && source $ZDOTDIR/.zsh_plugins.zsh
# Prompt setup
autoload -U promptinit; promptinit
[[ -d $ZDOTDIR ]] && source $ZDOTDIR/pure_prompt.zsh
prompt pure
# aliases

[[ -f ~/.secrets/env-secrets.sh ]] && source ~/.secrets/env-secrets.sh
source /home/rachee/.config/op/plugins.sh
