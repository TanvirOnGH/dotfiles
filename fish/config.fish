# set fish_greeting # Supress fish's intro message

set -x FISH_CONFIG_DIR $HOME/.config/fish

# Aliases
for file in $FISH_CONFIG_DIR/aliases/*.fish
    source $file
end

# Sets
for file in $FISH_CONFIG_DIR/sets/*.fish
    source $file
end

source $FISH_CONFIG_DIR/paths.fish
source $FISH_CONFIG_DIR/functions.fish
source $FISH_CONFIG_DIR/colors.fish

# grc: https://github.com/garabik/grc#fish
source $FISH_CONFIG_DIR/scripts/grc.fish

# <https://github.com/sharkdp/bat#man>
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANROFFOPT -c

# Auto-suggestion
set -g fish_autosuggestion_enabled 1

# Cursors
set fish_cursor_default underscore
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

function fish_greeting
    # source $FISH_CONFIG_DIR/greetings.fish
    # random choice $greetings
end

function fish_prompt
    echo (pwd) ":: "
end

function on_exit --on-event fish_exit
    echo "Exiting..."
end

if status is-interactive
    # ...
    # <https://zellij.dev/documentation/integration#fish>
    # eval (zellij setup --generate-auto-start fish | string collect)
    thefuck --alias | source
    cod init $fish_pid fish | source
    mcfly init fish | source
    atuin init fish | source
    zoxide init fish | source
end

if status is-login
    # ...
end

# Prompt
starship init fish | source

# direnv
direnv hook fish | source

# completions
# tdl completion fish | source

# ctrl+a
#[ -f ~/.inshellisense/key-bindings.fish ] && source ~/.inshellisense/key-bindings.fish

# argc-completions
set -gx ARGC_COMPLETIONS_ROOT "/home/user/.config/fish/completions/argc-completions"
set -gx ARGC_COMPLETIONS_PATH "$ARGC_COMPLETIONS_ROOT/completions"
fish_add_path "$ARGC_COMPLETIONS_ROOT/bin"
# To add a subset of completions only, change next line e.g. set argc_scripts cargo git
set argc_scripts (ls -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p')
argc --argc-completions fish $argc_scripts | source
