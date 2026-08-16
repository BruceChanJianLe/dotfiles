{ config, pkgs, ... }:

{
  # Shared packages across all users
  home.packages = [
    pkgs.bat
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
