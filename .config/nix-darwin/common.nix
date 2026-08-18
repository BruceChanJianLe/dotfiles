{ config, pkgs, ... }:

{
  # Shared packages across all users
  home.packages = [
    pkgs.bat
    pkgs.clang
    pkgs.gnumake
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
