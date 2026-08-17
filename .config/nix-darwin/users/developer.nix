{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = [
    pkgs.htop-vim
    pkgs.cmake-language-server
    pkgs.gdown
    pkgs.gh
    pkgs.git
  ];
}
