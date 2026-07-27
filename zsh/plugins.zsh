zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    atload"_setup_fzf_tab" \
    Aloxaf/fzf-tab \
    zdharma-continuum/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
    atload"_zsh_autosuggest_start; bindkey '^ ' autosuggest-accept" \
    zsh-users/zsh-autosuggestions \
    kutsan/zsh-system-clipboard

_setup_fzf_tab() {
    unfunction _setup_fzf_tab
    zstyle ":fzf-tab:*" use-fzf-default-opts yes
    zstyle ":fzf-tab:*" fzf-flags --preview-window="right:80%"
    zstyle ":fzf-tab:complete:*:*" fzf-preview "
    if [[ -d \$realpath ]]; then
        eza -1 --icons=always --color=always --group-directories-first -- \$realpath
    elif [[ -f \$realpath ]]; then
        bat --color=always --style=numbers,grid --line-range=:500 -- \$realpath
    else
        {
            tldr -m \$word 2>/dev/null ||
                man -m \$word 2>/dev/null ||
                echo \"No documentation available\"
        } | CLICOLOR_FORCE=1 COLORTERM=truecolor glow -s dark
    fi"
    zstyle ":fzf-tab:complete:*:options" fzf-preview ""
    zstyle ":fzf-tab:complete:*:argument-1" fzf-preview ""

    eval "$(fzf --zsh)"
}
