# set fish_greeting # Supress fish's intro message

function fish_greeting
    # https://fishshell.com/docs/current/cmds/fish_greeting.html
    random choice "Hello!" "Hi!" "Good day" \
        "Greetings Salutations" \
        "Hi there" "Howdy!" \
        "Pleased to make your acquaintance" "Hello, how's it going?" \
        "Hey, what's up?" "Hey there, how are you?" \
        "Hi, how's your day?" "Good to see you!" \
        "Hello, my friend" "Hello, world!" \
        "Hey, how's everything?" "What's new?" \
        "How's the weather out there?" "Hey, beautiful soul!" \
        "Hi, stranger!" "Long time no see!" \
        "Hey, buddy!" "Hi, pal!" "Hey, partner!" \
        "How's your day unfolding?" "Hello, dear friend!" \
        "Hey, lovely!" "What's on your mind?" \
        "Hi, fellow human!" "How's the world treating you?"
end

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

function fish_prompt
    echo (pwd) ":: "
end

function on_exit --on-event fish_exit
    echo "Exiting..."
end

if status is-interactive
    # ...
end

if status is-login
    # ...
end

thefuck --alias | source
cod init $fish_pid fish | source
mcfly init fish | source