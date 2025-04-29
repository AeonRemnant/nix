{ config, pkgs, lib, username, ... }:

{
  services.getty.autologinUser = username;
}