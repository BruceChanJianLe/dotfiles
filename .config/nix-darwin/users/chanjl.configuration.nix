# Per-user configuration for `chanjl`.
# Loaded as a nix-darwin module, so system options go at the top level and
# home-manager options are nested under `home-manager.users.${user}`.
{ config, pkgs, lib, user, ... }:

{
  system.defaults.dock.autohide = false;

  # ---------------------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------------------
  home-manager.users.${user} = {
    home.packages = [
      pkgs.htop-vim
    ];
  };
}
