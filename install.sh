#!/usr/bin/env bash
# Symlink every config in this repo to where its tool reads it.
# Safe to run again: correct links are skipped, real files are moved to <file>.backup first.
set -euo pipefail

DOTS="$(cd "$(dirname "$0")" && pwd)"
LIB="$HOME/Library/Application Support"

# repo path -> target path
links=(
  "zsh/.zshrc|$HOME/.zshrc"
  "zsh/oh-my-posh-theme.json|$HOME/.zsh/oh-my-posh-theme.json"
  "zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh|$HOME/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh"
  "tmux/.tmux.conf|$HOME/.tmux.conf"
  "tmux/scripts|$HOME/.config/tmux/scripts"
  "git/.gitconfig|$HOME/.gitconfig"
  "git/ignore|$HOME/.config/git/ignore"
  "delta/catppuccin.gitconfig|$HOME/.config/delta/catppuccin.gitconfig"
  "ghostty/config|$HOME/.config/ghostty/config"
  "lazygit/config.yml|$LIB/lazygit/config.yml"
  "gh/config.yml|$HOME/.config/gh/config.yml"
  "atuin/config.toml|$HOME/.config/atuin/config.toml"
  "bat/config|$HOME/.config/bat/config"
  "bat/themes|$HOME/.config/bat/themes"
  "glamour/catppuccin-macchiato.json|$HOME/.config/glamour/catppuccin-macchiato.json"
)

for pair in "${links[@]}"; do
  src="$DOTS/${pair%%|*}"
  dst="${pair#*|}"

  if [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
    echo "ok      $dst"
    continue
  fi

  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    backup="$dst.backup"
    [ -e "$backup" ] && backup="$dst.backup-$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$backup"
    echo "moved   $dst -> $backup"
  fi

  ln -s "$src" "$dst"
  echo "linked  $dst"
done

# bat reads themes from a cache, so rebuild it after linking.
if command -v bat >/dev/null; then
  bat cache --build >/dev/null
fi
