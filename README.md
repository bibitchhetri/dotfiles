# dotfiles

## Setup a new Mac

```bash
# 1. Add your SSH key to GitHub (https://github.com/settings/keys)
# 2. Run:
git clone git@github.com:bibitchhetri/dotfiles.git /tmp/dotfiles
bash /tmp/dotfiles/.config/dotfiles/bootstrap-mac.sh
```

Installs Homebrew + all packages, checks out every config into `$HOME`,
clones nvim ([lazy-dotfiles](https://github.com/bibitchhetri/lazy-dotfiles)),
wires iTerm2 prefs, then prints manual follow-ups (`gh auth login`, Keychain
tokens, tmux prefix + I).

## Daily use

```bash
dot status          # see changes
dot add -f <path>   # track a new file (-f required)
dot commit -m "..."
dot push
```

Secrets live in macOS Keychain / `~/.zshrc.local` — never in this repo.
