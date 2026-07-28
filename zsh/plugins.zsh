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

    # for list-colors
    eval "$(dircolors -b)"

    zstyle ":completion:*" matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
    zstyle ":fzf-tab:*" use-fzf-default-opts yes
    zstyle ":fzf-tab:*" fzf-flags --preview-window="right:70%"

    zstyle ":fzf-tab:complete:*:*" fzf-preview '
    mime=$(file -bL --mime-type "$realpath")
    category=${mime%%/*}
    if [[ -d $realpath ]]; then
        eza -1 --icons=always --color=always --group-directories-first $realpath
    elif [[ "$category" = text ]]; then
        bat --color=always --style=plain --line-range=:500 $realpath
    elif [[ "$category" = image ]]; then
        chafa $realpath
    else
        echo ${(P)word}
    fi'
    zstyle ":fzf-tab:complete:*:options" fzf-preview
    zstyle ":fzf-tab:complete:*:argument-1" fzf-preview

    # commands
    zstyle ":fzf-tab:complete:-command-:*" fzf-preview '
    {
        tldr -m "$word" 2>/dev/null ||
            man -m "$word" 2>/dev/null ||
            which "$word"
        } | CLICOLOR_FORCE=1 COLORTERM=truecolor glow -s dark
    '

    # kill|ps
    zstyle ":completion:*:*:*:*:processes" command "ps -u $USER -o pid,user,comm -w -w"
    zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
        '[[ $group == "[process ID]" ]] && ps --pid="$word" -o cmd --no-headers -w -w'
    zstyle ":fzf-tab:complete:(kill|ps):argument-rest" fzf-flags --preview-window=down:3:wrap

    # systemd
    zstyle ":fzf-tab:complete:systemctl:*" fzf-preview
    zstyle ":fzf-tab:complete:systemctl-*:*" fzf-preview 'SYSTEMD_COLORS=1 systemctl status "$word"'

    # pacman|paru
    zstyle ":fzf-tab:complete:(pacman|paru):*" fzf-preview 'pacman -Si ${(Q)word}'

    eval "$(fzf --zsh)"
}
