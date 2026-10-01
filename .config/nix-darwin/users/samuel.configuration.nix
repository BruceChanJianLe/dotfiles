{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.htop-vim
    pkgs.cmake-language-server
    pkgs.gdown
    pkgs.gh
    pkgs.git
  ];
}
