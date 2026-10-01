{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.htop-vim
  ];
}
