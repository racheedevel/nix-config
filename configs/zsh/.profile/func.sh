#!/bin/bash
### SHELL ###
gencompletion() {
    local name=$1; shift
    command -v "$name" >/dev/null || return 0
    eval "$*" > "$_zfunc/_$name" 2>/dev/null || return 0
}

reload-plugins() {
    local txt="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
    local zsh="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"
    [[ -r "$txt" ]] || { echo "No $txt"; return 1; }
    antidote bundle <"$txt" >|"$zsh" || return
    source "$zsh"

    # If fpath changed (e.g., new completions), rebuild compinit cache
    rm -f -- "${XDG_CACHE_HOME:-$HOME}/.zsh/zcompdump-*"
    compinit -C -d "${XDG_CACHE_HOME:-$HOME}/.zsh/zcompdump-${ZSH_VERSION}"
}

# Copying buffer
copy_current_command_to_clipboard() {
    echo -n $BUFFER | wl-copy
}

lc() {
    ls -lha | awk '{name=$9; for(i=10;i<=NF;i++){name=name" "$i}; printf "\033[31m%s\033[0m %s \033[32m%s\033[0m\n", $1, $5, name}' | tail -n+4 | column -t
}

# Move all of the files in the current directory
mvf() {
    mv $(find . -maxdepth 1 -type f) $@
}

receive_file() {
    CROC_SECRET="$1" croc
}

send_file() {
    code="$(pwgen 10 1)"
    croc send -c "$code" $@
}

pptxtopdf() {
    libreoffice --headless --invisible --convert-to pdf $@
}

pipe_nvim() {
    tmp=`mktemp`
    cat - > "$tmp"
    nvim "$tmp"
    cat "$tmp"
    rm "$tmp"
}

to_shellcode() {
  cat - | sed 's/0x//' | grep -o .. | tac | tr -d '\n' | sed 's/\(..\)/\\x\1/g'
}

genpass() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9:!-_*?+=@#$%,./' | fold -w 18 | head -n 1
}
### 


pdf() {
    nohup zathura $@ > /dev/null &
}

play() {
    nohup mpv $@ > /dev/null &
}
