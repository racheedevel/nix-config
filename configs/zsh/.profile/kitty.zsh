
# kitty-specific way to clear screen and put stuff in scrollback buffer
ctrl_l() {
    builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"$TTY"
    builtin zle .reset-prompt
    builtin zle -R
}
clear-only-screen() {
    printf "\e[H\e[2J"
}

clear-screen-and-scrollback() {
    printf "\e[H\e[3J"
}

clear-screen-saving-contents-in-scrollback() {
    printf "\e[H\e[22J"
}

if [[ "$TERM" == "kitty" ]]; then
    zle -N ctrl_l
    bindkey '^l' ctrl_l

    alias ssh='kitten ssh'
    alias icat='kitten icat'
    alias diff='kitten diff'
    alias hg='kitten hyperlinked-grep'
fi
