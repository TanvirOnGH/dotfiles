autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:git:*' formats "%F{red}[%b]%f"
zstyle ':vcs_info:*' enable git

PROMPT='%B%F{magenta}%n%f%F{yellow}@%F{blue}%m%f%F{green}:%F{cyan}:%f%F{red}$(git_prompt_info)%f %B%F{white}%D{%I:%M:%S %p}%f%b -> '

# argc-completions
export ARGC_COMPLETIONS_ROOT="/home/user/.config/fish/completions/argc-completions"
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"
export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
# To add a subset of completions only, change next line e.g. argc_scripts=( cargo git )
argc_scripts=( $(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
source <(argc --argc-completions zsh $argc_scripts)

# atuin
eval "$(atuin init zsh)"
# bind to the up key, which depends on terminal mode
bindkey '^[[A' atuin-up-search
bindkey '^[OA' atuin-up-search

# direnv
eval "$(direnv hook zsh)"
