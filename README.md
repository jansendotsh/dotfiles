# dotfiles

## Project

The scope here is to create a singular script that can be run to set up a full terminal environment on any Fedora machine that I may be working on. Currently, it pulls the following items:
* ZSH via Zim (incl. completions, autosuggestions, syntax highlighting and history-substring-search)
* Dracula themes (ZSH, Ghostty, tmux, Neovim)
* Ghostty terminal
* Neovim (incl. lazy.nvim, telescope, oil.nvim, neogit, gitsigns, mason, markdown-preview)
* yazi file browser, zoxide, fzf, Oh My Posh, and more
* CLI tools for cloud management (doctl, rclone, 1Password CLI)
* My personal dotfiles

## Install

* For Fedora:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jansendotsh/dotfiles/master/fedora.sh)"
```

## Layout

* `fedora.sh` — full workstation setup for a fresh Fedora install
* `script/bootstrap` — links the dotfiles and XDG configs into `$HOME`, sets up git config
* `zsh/` — zshrc, zimrc, aliases and the secrets template
* `config/` — XDG configs, linked into `~/.config` (ghostty, nvim)
* `tmux/`, `bash/`, `git/`, `latex/`, `bin/` — everything else

## Contributions

While this is a personal project, I'm more than happy to review feedback from other individuals on this matter. Feel free to submit pull requests and I'll review them appropriately.

## Credit

While a dotfile repository isn't anything original, credit the idea and certain blocks of code goes to jldeen's [dotfiles](https://github.com/jldeen/dotfiles).
