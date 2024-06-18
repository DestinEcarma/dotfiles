if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH_THEM
ZSH_THEME="powerlevel10k/powerlevel10k"

# Export
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/opt/nvim-linux64/bin"

# Plugins 
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My ZSH
source $ZSH/oh-my-zsh.sh

# aliases
alias bat="batcat"

# Setup powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom profile
if [ ! -d $HOME/.dotfiles/zsh/.profile ]; then
  source $HOME/.dotfiles/zsh/.profile
fi
