{ config, pkgs, ... }:

{
  # Shared packages across all users
  home.packages = [
    pkgs.neofetch
    pkgs.pixi
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
