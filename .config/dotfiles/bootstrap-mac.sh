#!/usr/bin/env bash
# Bootstrap a new Mac from the dotfiles repo.
# Usage: bash bootstrap-mac.sh   (run from anywhere; requires GitHub SSH access)
set -euo pipefail

DOTFILES_GIT="git@github.com:bibitchhetri/dotfiles.git"
NVIM_GIT="git@github.com:bibitchhetri/lazy-dotfiles.git"
DOTDIR="$HOME/.dotfiles.git"

dot() { /usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME" "$@"; }

step() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }

step "Checking Xcode Command Line Tools"
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish the install dialog, then re-run this script."
  exit 1
fi

step "Checking Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

step "Installing packages from Brewfile"
brew bundle --file="$HOME/.config/dotfiles/Brewfile"

step "Cloning dotfiles (bare repo)"
if [ ! -d "$DOTDIR" ]; then
  git clone --bare "$DOTFILES_GIT" "$DOTDIR"
fi
dot config status.showUntrackedFiles no
printf '*\n' > "$DOTDIR/info/exclude"

step "Installing Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

step "Installing tmux plugin manager (tpm)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

step "Checking out tracked dotfiles into \$HOME"
if [ -f "$HOME/.zshrc" ] && ! dot ls-files --error-unmatch .zshrc >/dev/null 2>&1; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.pre-dotfiles"
fi
dot checkout -f main

step "Cloning nvim config"
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone "$NVIM_GIT" "$HOME/.config/nvim"
fi

step "Pointing iTerm2 at managed preferences"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomizedFolder -bool true

step "Done. Manual steps:"
cat <<'EOF'
  1. gh auth login                      # restores GITHUB_TOKEN via `gh auth token`
  2. Store API tokens in Keychain:
       security add-generic-password -a "$USER" -s "cloudflare-api-token" -w '<token>'
       security add-generic-password -a "$USER" -s "jira-api-token"      -w '<token>'
  3. Launch tmux and press prefix + I to install TPM plugins.
  4. Start nvim once (lazy.nvim installs plugins automatically).
  5. Restart sketchybar / AeroSpace / yazi as needed.
EOF
