#!/bin/bash
# basics
alias ls="eza --group-directories-first --color -a --icons -l -o --no-symlinks"
alias ll="eza --group-directories-first --color -a --icons -l -o"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


# config
alias hyprvim="cd ~/.files/hyprland/.config/hypr && nvim hyprland.conf"
alias neovim="cd ~/.files/nvim/.config/nvim && nvim init.lua"
alias tmuxvim="nvim ~/.tmux.conf"
alias kittyvim="cd $HOME/.files/kitty/.config/kitty && nvim kitty.conf"
alias testvim="NVIM_APPNAME=nvim-test-plugin nvim"

# tools
alias glabs="GITLAB_HOST=git.securely.ai glab"
alias glabp="GITLAB_HOST=gitlab.com glab"
alias gglab="GITLAB_HOST=git.rachee.dev glab"
alias dragon="dragon-drop"
alias sage-jupyter="docker run -p 8888:8888 sagemath/sagemath:latest sage-jupyter"
alias venv="source ./.*/*/activate"
alias t="task -g"
alias l="ls"

alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias n="ninja"
alias c="clear"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
# Cleanup orphaned packages
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --height=40%
    --layout=reverse
    --border
    --info=inline
    --marker="* "
    --preview-window=right,50%,border
    --bind "j:down,k:up"
    --bind "/:clear-query"
'

# docker
_fzf_or_abort() { local s; s="$(cat)" || return 130; [[ -z "$s" ]] && return 130; print -r -- "$s"; }
_fzf_preview_trunc() { head -n 200 2>/dev/null || true }

_fd_select_compose_svc() {
    command -v jq >/dev/null || { echo "no jq?" >&2; return 1; }
    local dc=(docker compose); "${dc[@]}" version >/dev/null 2>&1 || dc=(docker-compose)
    "${dc[@]}" config --services 2>/dev/null \
        | fzf --prompt="compose svc> " --no-sort --ansi \
            --preview="printf \"Service: {}\\n\\n\"; ${dc[*]} config | _fzf_preview_trunc" \
        | _fzf_or_abort
}

_fd_select_container() {
    docker ps --format '{{.Names}}\t{{.Image}}\t{{.Status}}' \
    | fzf --prompt="container> " --with-nth=1,2,3 --delimiter='\t' \
        --preview='docker inspect --type container --format "{{json .}}" {1} | jq . | head -n 200 2>/dev/null' \
    | awk -F'\t' '{print $1}' | _fzf_or_abort
}

_fd_select_image() {
    docker images --format '{{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}' \
    | fzf --prompt="image> " --with-nth=1,3 --delimiter='\t' \
        --preview='docker inspect --type image --format "{{json .}}" {1} | jq . | head -n 200 2>/dev/null' \
    | awk -F'\t' '{print $1}' | _fzf_or_abort
}

fdcu() {
    local svc; svc="$(_fd_select_compose_svc)" || return
    local dc=(docker compose); "${dc[@]}" version >/dev/null 2>&1 || dc=(docker-compose)
    "${dc[@]}" up -d "$svc"
}


fdcd() {
    local svc; svc="$(_fd_select_compose_svc)" || return
    local dc=(docker compose); "${dc[@]}" version >/dev/null 2>&1 || dc=(docker-compose)
    "${dc[@]}" down "$svc"
}


fdck() {
    local c; c="$(_fd_select_container)" || return; docker kill "$c";
}

fdirm() {
    local i; i="$(_fd_select_image)" || return; docker image rm "$i";
}

fdcrm() {
    local c; c="$(_fd_select_container)" || return; docker container rm "$c";
}

fdcrs() {
    local c; c="$(_fd_select_container)" || return; docker restart "$c";
}

fdcl() {
    local c; c="$(_fd_select_container)" || return; docker logs -f --tail=200 "$c";
}
