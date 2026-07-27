#!/bin/zsh

SCRIPT_DIR="$HOME/.dotfiles/zsh"

[[ -f "$SCRIPT_DIR/.init" ]] && source "$SCRIPT_DIR/.init"

# Load Powerlevel10k instant prompt, if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not installed
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Setup powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

export FZF_DEFAULT_OPTS="--bind \"ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up\""

source "$SCRIPT_DIR/plugins.zsh"
source "$SCRIPT_DIR/history.zsh"
source "$SCRIPT_DIR/aliases.zsh"

eval "$(zoxide init --cmd cd zsh)"

# Load custom profile, if it exists
[[ -f "$SCRIPT_DIR/.profile" ]] && source "$SCRIPT_DIR/.profile"
