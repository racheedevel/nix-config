#!/bin/bash
# Cargo init
source $HOME/.cargo/env


eval "$(rbenv init -)"

# export ATUIN_NOBIND="true"
eval "$(atuin init zsh --disable-up-arrow)"


### FUNCTIONS ###
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/tmp/.local/state/lazygit_tmp/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

rb_init() {
    eval "$(rbenv init - --no-rehash zsh)"
}

nvm_init() {
  . /usr/share/nvm/init-nvm.sh
}

mise_init() {
    eval "$(mise activate zsh)"
}
source /home/rachee/.local/google-cloud-sdk/completion.zsh.inc
