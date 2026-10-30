# dotfiles

## Setup a new Mac

```bash
git clone git@github.com:bibitchhetri/dotfiles.git /tmp/dotfiles
bash /tmp/dotfiles/.config/dotfiles/bootstrap-mac.sh
```

Installs Homebrew packages, checks out all configs into `$HOME`,
clones nvim ([lazy-dotfiles](https://github.com/bibitchhetri/lazy-dotfiles)),
wires iTerm2 prefs.

Then finish manually:

```bash
gh auth login
security add-generic-password -a "$USER" -s "cloudflare-api-token" -w '<token>'
```

In tmux press `prefix + I` to install plugins.

## Sync changes

On this machine:

```bash
dot status
dot add -f <path>
dot commit -m "message"
dot push
```

On any other machine:

```bash
dot pull
```

Secrets live in macOS Keychain and `~/.zshrc.local`, never in this repo.
