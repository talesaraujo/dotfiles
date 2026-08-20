#!/usr/bin/env bash
# Bootstrap script: symlinks these dotfiles into $HOME and installs mise +
# every CLI tool declared in .config/mise/config.toml. Idempotent — safe to
# re-run on a machine that already has some of this set up.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/dotfiles-backup-$(date +%Y%m%d%H%M%S)"

link() {
  local src="$DOTFILES_DIR/$1" dest="$HOME/$1"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$1")"
    echo "backing up existing $dest -> $BACKUP_DIR/$1"
    mv "$dest" "$BACKUP_DIR/$1"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

echo "==> Linking dotfiles"
link .zshenv
link .zshrc
link .aliases
link .gitconfig
link .tmux.conf
link .config/starship.toml
link .config/mise/config.toml
link .config/fastfetch/config.jsonc

echo "==> Installing mise"
if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "mise already installed: $(mise --version)"
fi

echo "==> Installing tools declared in .config/mise/config.toml"
mise install

echo "==> Done."
echo "If zsh isn't your default shell yet, run: chsh -s \$(which zsh)"
echo "Open a new terminal (or run 'exec zsh') to pick everything up."
