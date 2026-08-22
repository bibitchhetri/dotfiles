# dotfiles

macOS dotfiles managed the DistroTube way: a **bare git repo** at `~/.dotfiles.git`
with `$HOME` as its work-tree. Files are tracked in place - no symlinks, no stow.

## Layout

| Path | What |
|---|---|
| `~/.zshrc` | zsh + oh-my-zsh (lambda prompt), fzf keybinds, aliases |
| `~/.oh-my-zsh/custom/themes/lambda.zsh-theme` | customized lambda theme |
| `~/.tmux.conf` | tmux + TPM plugins (resurrect/continuum/yank) |
| `~/bin/tmux-sessionizer` | fzf tmux session switcher (`~/.config/tmux-sessionizer/tmux-sessionizer.conf` sets search paths) |
| `~/.config/nvim/` | LazyVim config - lives in its own repo: [bibitchhetri/lazy-dotfiles](https://github.com/bibitchhetri/lazy-dotfiles), cloned by bootstrap |
| `~/.config/aerospace/` | AeroSpace tiling config |
| `~/.config/sketchybar/` | sketchybar setup |
| `~/.config/yazi/` | yazi file manager |
| `~/.config/ghostty/` | ghostty terminal |
| `~/.config/iterm2/com.googlecode.iterm2.plist` | iTerm2 prefs (iTerm2 loads/saves this folder directly) |
| `~/.config/gh/config.yml` | gh CLI settings (hosts.yml is NOT tracked - contains tokens) |
| `~/.doom.d/` | Doom Emacs config |
| `~/.gitconfig`, `~/.fzf.zsh` | git identity, fzf setup |
| `~/.config/dotfiles/Brewfile` | every brew tap/formula/cask on this machine |
| `~/.config/dotfiles/bootstrap-mac.sh` | full fresh-Mac restore script |

## Everyday use

```zsh
dot status            # what changed
dot add -f <path>     # track a new file (-f needed: home dir is ignore-all by default)
dot commit -m "..."
dot push
```

The `dot()` function is defined at the bottom of `.zshrc`.

## Secrets policy

- No credentials are ever committed. API tokens live in **macOS Keychain** and are
  pulled into the shell at login:
  ```zsh
  security add-generic-password -a "$USER" -s "jira-api-token"      -w '<token>'
  security add-generic-password -a "$USER" -s "cloudflare-api-token" -w '<token>'
  ```
  (`GITHUB_TOKEN` comes from `gh auth token`.)
- Machine-specific stuff goes in `~/.zshrc.local` - sourced if present, never tracked.
- The bare repo's `info/exclude` is `*`, so a stray `dot add .` can never sweep
  your home directory.

## Fresh Mac restore

```bash
git clone git@github.com:bibitchhetri/dotfiles.git /tmp/dotfiles
bash /tmp/dotfiles/.config/dotfiles/bootstrap-mac.sh
```

Requires SSH access to GitHub. The script installs Homebrew + all packages,
clones this repo as a bare repo, checks everything out into `$HOME`, clones
the nvim config, wires up iTerm2 preferences, then prints manual follow-ups
(`gh auth login`, Keychain tokens, TPM install).
