SCRIPT_DIR="$HOME/.dotfiles/zsh"

[[ ! -f "$SCRIPT_DIR/.init" ]] || source "$SCRIPT_DIR/.init"

# Load Powerlevel10k instant propmpt, if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not installed
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname "$ZINIT_HOME")"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi 

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Zinit plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Setup powerlevel10k
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings for autosuggestions and history search
bindkey "\e " autosuggest-accept
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# Histroy
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST="$HISTSIZE"
HISTDUP="erase"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:*" fzf
zstyle ":fzf-tab:complete:__zoxide:z:*" fzf

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Set default editor to nvim
export EDITOR="nvim"

# Aliases
alias ls="exa --icons"
alias cat="bat"
alias grep="rg"

# Load custom profile, if it exists
[[ ! -f "$SCRIPT_DIR/.profile" ]] || source "$SCRIPT_DIR/.profile"

