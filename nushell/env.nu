$env.GPG_TTY = (tty)
/nix/store/f61zfqzc5jc68rf2g05laszb73fxlwja-gnupg-2.4.5/bin/gpg-connect-agent updatestartuptty /bye | ignore

$env.SSH_AUTH_SOCK = ($env.SSH_AUTH_SOCK? | default (/nix/store/f61zfqzc5jc68rf2g05laszb73fxlwja-gnupg-2.4.5/bin/gpgconf --list-dirs agent-ssh-socket))

let starship_cache = "/home/user/.cache/starship"
if not ($starship_cache | path exists) {
  mkdir $starship_cache
}
/etc/profiles/per-user/user/bin/starship init nu | save --force /home/user/.cache/starship/init.nu

let atuin_cache = "/home/user/.cache/atuin"
if not ($atuin_cache | path exists) {
  mkdir $atuin_cache
}
/nix/store/ia0razxa5fyr1p9xqa1vqxxk82qymah0-atuin-18.3.0/bin/atuin init nu  | save --force /home/user/.cache/atuin/init.nu

