# Enable colors
autoload -U colors && colors

# Prompt status (green λ if success, red λ if fail)
local ret_status="%(?:%{$fg_bold[green]%}λ%{$reset_color%}:%{$fg_bold[red]%}λ%{$reset_color%})"

# Main prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# Git prompt styling
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

