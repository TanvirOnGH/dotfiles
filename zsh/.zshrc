autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:git:*' formats "%F{red}[%b]%f"
zstyle ':vcs_info:*' enable git

PROMPT='%B%F{magenta}%n%f%F{yellow}@%F{blue}%m%f%F{green}:%F{cyan}:%f%F{red}$(git_prompt_info)%f %B%F{white}%D{%I:%M:%S %p}%f%b -> '
