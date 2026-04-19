# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add .local/bin to path and insomnia
export PATH="$PATH:$HOME/.local/bin:/opt/insomnia"

# Move one word forwards or backswards
bindkey '^[0c' forward-word
bindkey '^[0d' backward-word

plugins=(git sudo)

eval "$(/opt/homebrew/bin/brew shellenv)"

# should probably be managed by oh-my-zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh

alias ls="lsd"
alias v="nvim"
alias fm="lfcd"

# nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# zoxide
eval "$(zoxide init zsh)"

# drop into current dir when using lf
LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
bindkey -s '^o' 'lfcd\n'

# alias cat='bat'

# Git diff for a specific commit
gitchanged ()
{
    git diff $1~ $1
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export EDITOR="nvim"

# Alias for the dotfiles repo
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# POWERLINE (starship)
eval "$(starship init zsh)"

# bun completions
[ -s "/home/topi/.bun/_bun" ] && source "/home/topi/.bun/_bun"

bindkey -v 

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
