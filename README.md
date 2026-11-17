<div align="center">

# DOTS

**Ghostty, tmux and zsh for macOS.**
Plain files and symlinks, no dotfiles manager, tmux prefix is <kbd>ctrl</kbd>+<kbd>b</kbd>.

[![Ghostty](https://img.shields.io/badge/terminal-Ghostty-3551F3?style=flat-square)](https://ghostty.org)
[![tmux](https://img.shields.io/badge/tmux-1BB91F?style=flat-square&logo=tmux&logoColor=white)](https://github.com/tmux/tmux)
[![zsh](https://img.shields.io/badge/shell-zsh-F15A24?style=flat-square&logo=zsh&logoColor=white)](https://www.zsh.org)
[![Catppuccin](https://img.shields.io/badge/theme-catppuccin%20macchiato-f5a97f?style=flat-square)](https://github.com/catppuccin/catppuccin)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

</div>

## ✨ Features

- **Ghostty draws, tmux manages.** Ghostty attaches to tmux on launch. Tabs are tmux windows and splits are tmux panes.
- **macOS keys.** <kbd>cmd</kbd>+<kbd>t</kbd>, <kbd>cmd</kbd>+<kbd>d</kbd> and <kbd>cmd</kbd>+<kbd>1</kbd>…<kbd>9</kbd> drive tmux, so it feels like native tabs.
- **Popups.** Renaming and killing windows open a small centered popup. Picking a window that does not exist shows a red one.
- **One theme.** Catppuccin Macchiato in Ghostty, tmux, zsh highlighting, fzf, delta, bat, lazygit and glamour.
- **History with context.** Atuin takes over <kbd>ctrl</kbd>+<kbd>r</kbd> and the up arrow.
- **Signed commits.** SSH signing, with the name, email and key kept outside the repo.
- **Safe install.** `install.sh` can run again. It skips correct links and backs up real files first.

## 📦 Requirements

| Tool                                                                                                                                                                           | Used by                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------- |
| macOS, [Homebrew](https://brew.sh)                                                                                                                                             | everything                 |
| [Ghostty](https://ghostty.org), [VictorMono Nerd Font](https://rubjo.github.io/victor-mono/)                                                                                   | terminal                   |
| [tmux](https://github.com/tmux/tmux), [tpm](https://github.com/tmux-plugins/tpm)                                                                                               | windows, panes, plugins    |
| [Oh My Zsh](https://ohmyz.sh), [oh-my-posh](https://ohmyposh.dev)                                                                                                              | shell, prompt              |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)                       | shell                      |
| [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep), [Atuin](https://atuin.sh)                                                            | file and history search    |
| [fnm](https://github.com/Schniz/fnm), [eza](https://eza.rocks), [bat](https://github.com/sharkdp/bat)                                                                          | Node versions, `ls`, `cat` |
| [delta](https://github.com/dandavison/delta), [lazygit](https://github.com/jesseduffield/lazygit), [gh](https://cli.github.com), [glow](https://github.com/charmbracelet/glow) | git                        |

The `Brewfile` installs all of them except Oh My Zsh, zsh-syntax-highlighting and tpm.

## 🚀 Install

```sh
git clone git@github.com:ecelustka/dots.git ~/dots
cd ~/dots

brew bundle
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

./install.sh
```

Open tmux and press <kbd>ctrl</kbd>+<kbd>b</kbd> then <kbd>I</kbd> to install the tmux plugins.

Then create the machine-only files. They are not in the repo:

- `~/.gitconfig.local` holds the `[user]` name, email and signing key.
- `~/.zshrc.local` holds aliases and exports for one machine. It loads at the end of `~/.zshrc`.

## 🗂️ Layout

```
install.sh        symlinks each file below to where its tool reads it
Brewfile          tools and the font
ghostty/config    ~/.config/ghostty/config
tmux/.tmux.conf   ~/.tmux.conf
tmux/scripts/     ~/.config/tmux/scripts, popups for rename, kill, goto window
zsh/              ~/.zshrc, prompt theme, syntax highlighting colors
git/              ~/.gitconfig, global ignore
delta/            ~/.config/delta, diff theme
lazygit/          ~/Library/Application Support/lazygit
gh/               ~/.config/gh/config.yml
atuin/            ~/.config/atuin
bat/              ~/.config/bat, config and theme
glamour/          ~/.config/glamour, markdown theme for gh and glow
```

## ⌨️ Keymaps

<details open>
<summary><b>Ghostty</b> (sends tmux keys)</summary>

| Key                               | Action                               |
| --------------------------------- | ------------------------------------ |
| `cmd+t`                           | new window                           |
| `cmd+w`                           | kill pane (asks first)               |
| `cmd+1` – `cmd+9`                 | go to window                         |
| `cmd+d` `cmd+shift+d`             | split right / down                   |
| `cmd+alt+h/j/k/l`                 | move between panes                   |
| `cmd+shift+enter`                 | zoom pane                            |
| `alt+left` `alt+right`            | jump a word in the shell             |
| `cmd+p` `cmd+f` `cmd+e` `cmd+g` … | send `,p` `,f` `,e` `,g` … to Neovim |

</details>

<details>
<summary><b>tmux</b> (after <kbd>ctrl</kbd>+<kbd>b</kbd>)</summary>

| Key             | Action                                                    |
| --------------- | --------------------------------------------------------- |
| `c` `%` `"`     | new window / split right / down, in the current directory |
| `h` `j` `k` `l` | move between panes                                        |
| `,` `$`         | rename window / session in a popup                        |
| `x` `&`         | kill pane / window, confirm in a popup                    |
| `0` – `9`       | go to window, popup if it is missing                      |
| `v` `y`         | select / copy in copy mode (vi keys)                      |

</details>

<details>
<summary><b>Shell</b></summary>

| Alias                                                | Runs                               |
| ---------------------------------------------------- | ---------------------------------- |
| `vim`                                                | `nvim`                             |
| `lg`                                                 | `lazygit`                          |
| `ls` `ll` `lt`                                       | `eza`: list / long with git / tree |
| `zshconfig` `tmuxconfig` `ghosttyconfig` `vimconfig` | open that config                   |
| `myip`                                               | public IP                          |

</details>

## 🎨 Credits

Color themes for delta, bat, lazygit, glamour and zsh-syntax-highlighting come from
[Catppuccin](https://github.com/catppuccin).

## 📄 License

[MIT](LICENSE)
