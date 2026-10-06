# Per-user configuration for `raus`.
# Loaded as a nix-darwin module, so system options go at the top level and
# home-manager options are nested under `home-manager.users.${user}`.
{ config, pkgs, lib, user, ... }:

{
  system.defaults.dock.autohide = false;

  homebrew = {
    taps = [
      "brucechanjianle/hyprdarwin"
    ];

    casks = [
      "ghostty"
      "brave-browser"
      "claude-code"
      "foxglove"
      "keycastr"
      "obsidian"
      "zoom"
      "slack"
      "xquartz" # ssh -X
      "whatsapp"
      "microsoft-teams"
      "spotify"
      "brucechanjianle/hyprdarwin/hyprdarwin"
    ];

    brews = [
      "ansible" "cmake" "cppcheck" "glog" "libusb" "ccache" "wget"
      "neovim" "ripgrep" "fd" "luarocks" "imagemagick" "virtualenv"
      "tmux"
      "fzf"
      "tailscale" "pixi"
      "gcc" "tbb"
      "ffmpeg"
      "node"
      "ninja"
      "xcodegen"
    ];

    # "none" - leaves undeclared packages alone, so the list above is additive
    # "uninstall" - remove anything not declared (the declarative choice)
    # "zap"       - same, plus delete app data/config (destructive; only
    #               for a deliberate purge, not routine activation)
    onActivation = {
      cleanup = "none";
    };
  };

  # Homebrew refuses to load casks from non-official taps until trusted.
  # Declared here so a fresh machine needs no manual `brew trust`.
  # Note: entries are NOT revoked by removing them - use `brew untrust`.
  nix-homebrew.trust.casks = [
    "brucechanjianle/hyprdarwin/hyprdarwin"
  ];
  # ---------------------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------------------
  home-manager.users.${user} = {
    home.packages = [
      pkgs.htop-vim
    ];
  };
}
