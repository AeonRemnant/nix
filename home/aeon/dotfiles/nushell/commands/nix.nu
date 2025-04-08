# Updates Nix config git and rebuilds.
export def nix-rebuild [] {
    print "Changing directory to ~/.config/nix"
    cd ~/.config/nix

    print "Fetching git updates..."
    git fetch

    print "Running nixos-rebuild..."
    sudo nixos-rebuild switch --flake ~/.config/nix#forge
}

# Checks the latest Home Manager generation in the Nix store.
export def nix-checkgen [] {
    # Find latest HM gen path
    let hm_gen_path = (try {
        ls -ltd '/nix/store/*-home-manager-generation' | first | get name
    } catch { |err|
        # Error if no generations found
        error make {
            msg: "Failed to find any Home Manager generations in /nix/store.",
            label: { text: $"Original error: ($err.msg)" } # Removed span field
        }
        return # Stop execution
    })

    print $"Inspecting Latest HM Generation: ($hm_gen_path)"
    print "---"

    # List top level contents
    print $"(ansi yellow)Top Level Contents:(ansi reset)"
    ls -l $hm_gen_path
    print "---"

    # Check /bin/ directory
    print $"(ansi yellow)Bin Contents (/bin/):(ansi reset)"
    let bin_path = $"($hm_gen_path)/bin"
    try {
        ls -l $bin_path
    } catch { |err|
        # Handle common 'not found' errors gracefully
        if ($err | to nuon | str contains "nu::shell::io") {
            print $"(ansi dark_gray)(Directory ($bin_path) likely empty or does not exist)(ansi reset)"
        } else {
            # Print other unexpected errors
            print $"(ansi red)Error listing ($bin_path): ($err.msg)(ansi reset)"
        }
    }
    print "---"

    # Check /share/icons/ directory
    print $"(ansi yellow)Share/Icons Contents (/share/icons/):(ansi reset)"
    let icons_path = $"($hm_gen_path)/share/icons"
    try {
        ls -l $icons_path
    } catch { |err|
        if ($err | to nuon | str contains "nu::shell::io") {
            print $"(ansi dark_gray)(Directory ($icons_path) likely empty or does not exist)(ansi reset)"
        } else {
            print $"(ansi red)Error listing ($icons_path): ($err.msg)(ansi reset)"
        }
    }
    print "---"
}