$env.GPG_TTY = (tty)
/nix/store/35r5l02cwhprbakyn5lraij0lifkm0s5-gnupg-2.4.5/bin/gpg-connect-agent updatestartuptty /bye | ignore

$env.SSH_AUTH_SOCK = ($env.SSH_AUTH_SOCK? | default (/nix/store/35r5l02cwhprbakyn5lraij0lifkm0s5-gnupg-2.4.5/bin/gpgconf --list-dirs agent-ssh-socket))

let atuin_cache = "/home/user/.cache/atuin"
if not ($atuin_cache | path exists) {
  mkdir $atuin_cache
}
/nix/store/xhd382paw81fhwxm4x240m1bk4hbiql4-atuin-18.3.0/bin/atuin init nu  | save --force /home/user/.cache/atuin/init.nu
