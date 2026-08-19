# ~/.zshenv — carregado por TODO zsh (interativo, scripts, login).
# Só PATH/exports que precisam existir mesmo em shells não-interativos.

typeset -U path

path=(
  "$HOME/.local/bin"
  "$HOME/.local/share/mise/shims"
  $path
)

export PATH
