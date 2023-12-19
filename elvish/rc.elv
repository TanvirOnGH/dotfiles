# argc-completions
set E:ARGC_COMPLETIONS_ROOT = '/home/user/workspace/argc-completions'
set E:ARGC_COMPLETIONS_PATH = $E:ARGC_COMPLETIONS_ROOT'/completions'
set paths = [(echo $E:ARGC_COMPLETIONS_ROOT'/bin') $@paths]
# To add a subset of completions only, change next line e.g. var argc_scripts = ["cargo" "git"]
var argc_scripts = [(ls -p -1 $E:ARGC_COMPLETIONS_ROOT'/completions' | sed -n 's/\.sh$//p')]
eval (argc --argc-completions elvish (all $argc_scripts) | slurp)
