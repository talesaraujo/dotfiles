# #------------------------------ WSL Settings ---------------------------------#
# # Fix WSL2 interop/explorer
# for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
#     if [[ -e "/run/WSL/${i}_interop" ]]; then
#         export WSL_INTEROP=/run/WSL/${i}_interop
#     fi
# done

# ### VcXsrv X-Server Settings
# # export DISPLAY=ASUS-TUF.local:0.0
# # export LIBGL_ALWAYS_INDIRECT=1
# # export XDG_RUNTIME_DIR="$HOME/.wsl-xserver/$USER"
# # export RUNLEVEL=3

# ### WSLg [ does not work with abnt2 keyboard !!! ]
# # Fix keyboard layout issue
# export WAYLAND_DISPLAY="wayland-1"
# setxkbmap -model abnt2 -layout br -variant abnt2

# # export GTK_THEME="Fluent-dark"

#------------------- Development Environment Variables -----------------------#
# Pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# Poetry
export PATH="/home/tales/.local/bin:$PATH"

# Rust support
source "$HOME/.cargo/env"

# MS SQL-Server
export PATH="$PATH:/opt/mssql-tools/bin"
