# Utilities
alias eza="eza --icons -s type"
alias ls="eza"
alias ll="ls -al"
alias cat="bat"
alias grep="rg"
alias tree="eza -T"
alias ..="cd .."
alias c="clear"
alias src="source ~/.zshrc"

# Pacman
alias pacman-is="pacman -Slq | fzf --multi --preview \"pacman -Si {1}\" | xargs -ro sudo pacman -S"
alias pacman-rs="pacman -Qq | fzf --multi --preview \"pacman -Qi {1}\" | xargs -ro sudo pacman -Rns"
alias pacman-clean="orphans=\$(pacman -Qtdq); [[ -n \$orphans ]] && sudo pacman -Rns \$orphans"

# Paru
alias paru-is="paru -Slq | fzf --ansi --multi --preview \"paru -Si {1}\" | xargs -ro paru -S"
alias paru-rs="paru -Qmq | fzf --multi --preview \"paru -Qi {1}\" | xargs -ro paru -Rns"
alias paru-igp="paru -Qmq | fzf --multi --preview \"paru -Gp {1} | bat --color=always --style=plain -l sh\""
