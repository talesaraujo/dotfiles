#!/bin/bash

export STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.local/share/Steam
export STEAM_COMPAT_DATA_PATH=~/.local/share/Steam/steamapps/compatdata
export DXVK_STATE_CACHE_PATH=~/.dxvk/cache

$HOME/.local/share/Steam/steamapps/common/Proton\ -\ Experimental/proton run "$1"
