{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pulumi
    pulumictl
    pulumi-esc
    pulumiPackages.pulumi-go
  ];
}