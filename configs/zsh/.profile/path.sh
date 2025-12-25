#!/bin/bash
export PATH="/home/rachee/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.scripts:$PATH"
export PATH="/home/rachee/.bun/bin:$PATH"
export PATH="/home/rachee/.local/google-cloud-sdk/bin:$PATH"
export PATH="/home/rachee/.local/py_bin:$PATH"
export PATH="/home/rachee/.krew/bin:$PATH"

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

