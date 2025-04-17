# Updates Nix config git and rebuilds.
export def rebuild [
    mode?: string = "dev"
] {

    let dev_dir = $"($env.HOME)/.config/nix"
    let prod_dir = $"($env.HOME)/nix-prod-config"

    print $"--- Running rebuild in '($mode)' mode ---"

    match $mode {
        "prod" => {
            print $"Target directory: ($prod_dir)"
            if not ($prod_dir | path exists) {
                error make { msg: $"Production directory not found: ($prod_dir)" }
            }

            print "Changing directory..."
            cd $prod_dir

            print "Pulling git updates..."
            match (git pull) {
                {exit_code: 0} => { print "Git pull successful." },
                $err => { print $"Warning: git pull failed: ($err.stderr)" }
            }

            print "Running nixos-rebuild (prod)..."
            sudo nixos-rebuild switch --flake $"($prod_dir)#forge"
        },

        "dev" => {
            print $"Target directory: ($dev_dir)"
             if not ($dev_dir | path exists) {
                error make { msg: $"Development directory not found: ($dev_dir)" }
            }

            print "Changing directory..."
            cd $dev_dir

            print "Running nixos-rebuild (dev)..."
            sudo nixos-rebuild switch --flake $"($dev_dir)#forge"
        },

        _ => {
            error make { msg: $"Invalid mode: '($mode)'. Please use 'dev' or 'prod'." }
        }
    }
    print $"--- Rebuild '($mode)' mode finished ---"
}
