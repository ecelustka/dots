# ~/.zshrc — part of github.com/ecelustka/dots

# ── PATH ─────────────────────────────────────────────────────────
export GOPATH="$HOME/go"
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$PNPM_HOME:$BUN_INSTALL/bin:/usr/local/bin:$PATH"

# ── oh-my-zsh ────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode disabled   # skip the startup update check (~50ms); update manually with `omz update`
ZSH_DISABLE_COMPFIX=true             # skip compaudit permission scan (~15ms)
ZSH_THEME=""                         # prompt comes from oh-my-posh, don't load an omz theme
plugins=(git fnm copypath copyfile)
source "$ZSH/oh-my-zsh.sh"

# ── Prompt ───────────────────────────────────────────────────────
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.zsh/oh-my-posh-theme.json)"
fi

# ── Tools ────────────────────────────────────────────────────────
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,.svelte-kit/*,build/*}"'
# Catppuccin Macchiato — fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"
# Catppuccin Macchiato — glamour (gh pr/issue view, glow)
export GLAMOUR_STYLE="$HOME/.config/glamour/catppuccin-macchiato.json"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
source <(fzf --zsh)                                          # Ctrl-T files, Alt-C cd (Ctrl-R overridden by atuin below)
eval "$(atuin init zsh)"                                     # history: Ctrl-R / Up-arrow search
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"   # bun completions

# ── Aliases ──────────────────────────────────────────────────────
alias vim="nvim"
alias lg="lazygit"
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim"
alias tmuxconfig="vim ~/.tmux.conf"
alias ghosttyconfig="vim ~/.config/ghostty/config"
alias myip="curl ifconfig.me"
alias ls="eza --icons=auto"
alias ll="eza -l --icons=auto --git"
alias lt="eza --tree --icons=auto --level=2"

# ── Autosuggestions + syntax highlighting (highlighting last) ────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6e738d"
source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── Machine-only settings (not in the repo) ──────────────────────
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
