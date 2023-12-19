# argc-completions
$ARGC_COMPLETIONS_ROOT = '/home/user/workspace/argc-completions'
$ARGC_COMPLETIONS_PATH = $ARGC_COMPLETIONS_ROOT + '/completions'
$PATH.insert(0, $ARGC_COMPLETIONS_ROOT + '/bin')
import os
# To add a subset of completions only, change next line e.g. argc_scripts = ["cargo", "git"]
argc_scripts = list(map(lambda v: v.removesuffix('.sh'), filter(lambda v: v.endswith('.sh'), os.listdir($ARGC_COMPLETIONS_ROOT + '/completions'))))
exec($(argc --argc-completions xonsh @(argc_scripts)))
