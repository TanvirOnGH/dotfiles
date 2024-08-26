def --env yy [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

alias fuck = /nix/store/b6in4yqiqabwajbrcd4sqszdg17djw8z-thefuck-3.32/bin/thefuck $"(history | last 1 | get command | get 0)"

use /home/user/.cache/starship/init.nu

source /home/user/.cache/atuin/init.nu

$env.config = ($env.config? | default {})
$env.config.hooks = ($env.config.hooks? | default {})
$env.config.hooks.pre_prompt = (
    $env.config.hooks.pre_prompt?
    | default []
    | append {||
        let direnv = (/nix/store/1mrvvx2ygfyfz8sn3gg5f3qidvd9s8j1-direnv-2.34.0/bin/direnv export json
        | from json
        | default {})
        if ($direnv | is-empty) {
            return
        }
        $direnv
        | items {|key, value|
            {
                key: $key
                value: (do (
                    $env.ENV_CONVERSIONS?
                    | default {}
                    | get -i $key
                    | get -i from_string
                    | default {|x| $x}
                ) $value)
            }
        }
        | transpose -ird
        | load-env
    }
)

alias eza = eza '--icons' '--git'