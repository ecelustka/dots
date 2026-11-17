#!/usr/bin/env bash
# Interactive rename input for tmux display-popup.
# Enter = apply, Esc = cancel, Backspace = edit, empty = cancel.
kind="$1"   # "window" or "session"

printf ' new name: '
name=''
while IFS= read -rsn1 ch; do
  case "$ch" in
    $'\e') exit 0 ;;               # Esc (also catches arrow-key sequences)
    ''|$'\r'|$'\n') break ;;       # Enter (LF, CR, or read delimiter)
    $'\x7f'|$'\b')                 # Backspace
      if [ -n "$name" ]; then
        name="${name%?}"
        printf '\b \b'
      fi ;;
    [[:print:]]) name+="$ch"; printf '%s' "$ch" ;;
  esac
done
[ -n "$name" ] && tmux "rename-$kind" -- "$name"
