alias fuck = /nix/store/i6awqnp25wivylc8vdd8l8j55wid4p2z-thefuck-3.32/bin/thefuck $"(history | last 1 | get command | get 0)"

source /home/user/.cache/atuin/init.nu

$env.config = ($env.config? | default {})
$env.config.hooks = ($env.config.hooks? | default {})
$env.config.hooks.pre_prompt = (
    $env.config.hooks.pre_prompt?
    | default []
    | append {||
        let direnv = (/nix/store/iq73997k0rsvb1rgglx0s5z224qr86jk-direnv-2.34.0/bin/direnv export json
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
