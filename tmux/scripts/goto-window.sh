#!/usr/bin/env bash
# Select window N (prefix 0-9). If it does not exist, show a small centered
# popup instead of tmux's plain "can't find window" status-line message.
# Popup auto-dismisses after ~1.2s or on any key.
#
# Usage: goto-window.sh N          (bound in tmux.conf)
#        goto-window.sh --show N   (internal: body rendered inside the popup)
if [[ "$1" == "--show" ]]; then
  printf '   window %s does not exist' "$2"
  read -t 1.2 -rsn1
  exit 0
fi

n="$1"
tmux select-window -t ":=$n" 2>/dev/null && exit 0

tmux display-popup -w 30 -h 3 \
  -S "fg=#ed8796" \
  -T "#[fg=#ed8796,bold]  no window $n " \
  -E "bash '$0' --show '$n'"
