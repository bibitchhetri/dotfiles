# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Keep custom themes/plugins outside the oh-my-zsh tree so dotfiles can track them
export ZSH_CUSTOM="$HOME/.config/zsh-custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="lambda"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="lsd"
alias nv="nvim"
alias emacs='emacsclient -c -n & disown'
alias em=emacs
alias fresh='printf "\033c\e[3J"'

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# pyenv setup
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Enable ** globbing
setopt extended_glob
setopt globstarshort

# # Enable recursive globbing (for **)
# setopt globstar


# Fuzzy cd widget (skip dotfiles, silent cd)
fzf-cd-widget() {
  local dir
  dir=$(find . -type d -not -path '*/\.*' 2>/dev/null | \
        fzf --height 40% --reverse --border) || return

  # Directly change directory (no printing, no leftover "cd **")
  cd "$dir" || return

  # Clear the buffer so nothing remains on the command line
  BUFFER=""
  zle reset-prompt
}

# Only trigger if command buffer is "cd **"
fzf-tab-or-complete() {
  if [[ $BUFFER == "cd **" ]]; then
    zle fzf-cd-widget
  else
    zle expand-or-complete   # normal TAB behavior
  fi
}

zle -N fzf-tab-or-complete
bindkey '^I' fzf-tab-or-complete   # ^I is TAB
export PATH="$HOME/.config/emacs/bin:$PATH"

# --- FZF & NEVOM PRODUCTIVITY SETUP ---
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="--height 90% --layout=reverse --border=rounded --info=inline"

inv() {
  local res
  local file
  local line

  res=$(rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/*' "${1:-.}" | \
    fzf --ansi \
        --delimiter : \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --preview-window 'right:60%:+{2}-10')

  if [[ -n "$res" ]]; then
    file=$(echo "$res" | cut -d: -f1)
    line=$(echo "$res" | cut -d: -f2)
    nvim "+$line" "$file"
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -s '^f' 'inv\n'

# tmux-sessionizer (Keep at the very bottom)
export PATH="$HOME/bin:$PATH"
# dotnet-ef path
export PATH="$PATH:$HOME/.dotnet/tools"
# opencode and graphify path
export PATH="$HOME/.local/bin:$PATH"
# API tokens (stored in macOS Keychain, never in this file)
export GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
export CLOUDFLARE_API_TOKEN="$(security find-generic-password -a "$USER" -s "cloudflare-api-token" -w 2>/dev/null)"
export JIRA_API_TOKEN="$(security find-generic-password -a "$USER" -s "jira-api-token" -w 2>/dev/null)"

# Machine-local overrides (untracked): put secrets/one-off exports here
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# --- dotfiles manager (bare git repo) ---
dot() {
  /usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME" "$@"
}
