{ pkgs, inputs, ... }: 

{
    programs.spacemacs = {
        enable = true;
        package = pkgs.spacemacs;
    };
}