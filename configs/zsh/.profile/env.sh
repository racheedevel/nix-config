#!/bin/bash
### S-tier ###
export LISTMAX=1000
ENABLE_CORRECTION="false"

COMPLETION_WAITING_DOTS="false"
# Ignore some commands from history
export HISTIGNORE="&:ls:[bf]g:c:clear:history:exit:q:pwd:* --help:kubectl create secret:* -h"
# Timestamp format for history records
HIST_STAMPS="mm/dd/yyyy"
# Change data path to .local/share
export XDG_DATA_HOME="$HOME/.local/share"
# Simplifies editing zsh sourced files
export ZPROF="$ZDOTDIR/.profile"


# Eza (ls)
export EZA_CONFIG_DIR='/Users/rachee/.config/eza'
# 1Password
export OP_BIOMETRIC_UNLOCK_ENABLED=true
# Wtfis network/ip/asn sniffer
export WTFIS_DEFAULTS="-u -1"
# Minimal style adjustment for qt apps
export QT_QPA_PLATFORMTHEME="qt5ct"
# History substring search remove duplicates
export KUBECONFIG="$HOME/.kube/kubeconfig"


export FOCUSRITE_MIC="alsa_input.usb-Focusrite_Scarlett_Solo_USB_Y7ZY0HB497A3FD-00.HiFi__Mic1__source"
export AIRPODS="bluez_output.90_62_3F_5A_23_A4.1"
export UV_PREVIEW=1
