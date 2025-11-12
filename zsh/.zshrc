# Load init, if it exists (Load this before powerlevel10k instant prompt)
[[ ! -f $HOME/.dotfiles/zsh/.init ]] || source $HOME/.dotfiles/zsh/.init

# Load Powerlevel10k instant propmpt, if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not installed
if [ ! -d $ZINIT_HOME ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi 

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Zinit plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Setup powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings for autosuggestions and history search
bindkey "^ " autosuggest-accept
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# Histroy
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

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
zstyle ":fzf-tab:complete:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide:z:*" fzf-preview "ls --color $realpath"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Set default editor to nvim
export EDITOR=nvim

# Aliases
alias ls="ls --color"

# Load custom profile, if it exists
[[ ! -f $HOME/.dotfiles/zsh/.profile ]] || source $HOME/.dotfiles/zsh/.profile

