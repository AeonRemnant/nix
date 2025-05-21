{ pkgs, ... }: 

{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      if (which keychain | is-ok) {
        keychain --eval --quiet ~/.ssh/id_ed25519
          | lines
          | where not ($it | is-empty)
          | parse "{k}={v}; export {k2};"
          | select k v
          | transpose --header-row
          | into record
          | load-env
      }
    '';
  };
}