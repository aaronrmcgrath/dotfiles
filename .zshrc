
# p10k instant prompt — macOS only
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.bin
[[ -d /usr/local/go/bin ]] && export PATH=$PATH:/usr/local/go/bin
[[ -d "$HOME/go/bin" ]] && export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:~/.composer/vendor/bin

export ZSH="$HOME/.oh-my-zsh"

# Theme — p10k on macOS, starship handles it on Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
else
  ZSH_THEME=""
  typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
fi

# zsh-autosuggestions
if [[ "$OSTYPE" == "darwin"* ]]; then
  [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
  [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

plugins=(
    git
    vi-mode
    aliases
    battery
    fzf
    chucknorris
)

[[ "$OSTYPE" == "darwin"* ]] && plugins+=(brew)

DISABLE_FZF_AUTO_COMPLETION="false"
DISABLE_FZF_KEY_BINDINGS="false"

source $ZSH/oh-my-zsh.sh

# Prompt
if [[ "$OSTYPE" == "darwin"* ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  eval "$(starship init zsh)"
fi

# fastfetch on shell start
command -v fastfetch &>/dev/null && fastfetch

# ALIASES
alias v="nvim +Exp"
alias art="php artisan"
alias mls="ls -la"
alias ~="cd ~"
alias b="cd ../"
alias cl="clear"

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# DIRECTORY ALIASES
alias ez="nvim ~/.zshrc"
alias nvd="cd ~/.config/nvim/"

# PROJECT ALIASES
alias arm="cd ~/Documents/Atom_Projects/personal_website/"
alias trippn="cd ~/Projects/repos/trippin/"
alias garden="cd ~/Documents/Atom_Projects/Projects/home_grown/homegrownv2/"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# thefuck — guard in case not installed
command -v thefuck &>/dev/null && eval $(thefuck --alias)

export PATH="$HOME/.local/bin:$PATH"

# flyctl — guard in case not installed
[[ -d "$HOME/.fly/bin" ]] && export FLYCTL_INSTALL="$HOME/.fly" && export PATH="$FLYCTL_INSTALL/bin:$PATH"

# mempalace — disable ChromaDB telemetry
export ANONYMIZED_TELEMETRY=False
