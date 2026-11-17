#!/usr/bin/env bash
# Confirm-kill for tmux display-popup. y = kill, anything else = cancel.
# Target resolved from inside the popup: the popup overlays the pane that
# was active when it opened, so "current pane/window" IS the target.
# (display-popup does not format-expand its command, so the caller
# cannot pass #{pane_id} — resolving here is the reliable way.)
what="$1"   # "pane" or "window"

case "$what" in
  pane)   target=$(tmux display -p '#{pane_id}') ;;
  window) target=$(tmux display -p '#{window_id}') ;;
  *) exit 1 ;;
esac

printf ' kill this %s? [y/N] ' "$what"
IFS= read -rsn1 ch
case "$ch" in
  y|Y) tmux "kill-$what" -t "$target" ;;
esac
