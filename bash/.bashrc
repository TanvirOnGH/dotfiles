# If PROMPT_COMMAND variable is set then just merge own pre_prompt_command with the following one.
source /home/user/.config/bash/bash-wakatime/bash-wakatime.sh

# Prompt
PS1="\[\033[1;32m\]\u@\h\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] :: "

# argc-completions
export ARGC_COMPLETIONS_ROOT="/home/user/.config/fish/completions/argc-completions"
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"
export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
# To add a subset of completions only, change next line e.g. argc_scripts=( cargo git )
argc_scripts=( $(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
source <(argc --argc-completions bash "${argc_scripts[@]}")
