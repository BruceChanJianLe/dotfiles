# Per-user configuration for `developer`.
# Loaded as a nix-darwin module, so system options go at the top level and
# home-manager options are nested under `home-manager.users.${user}`.
{ config, pkgs, lib, user, ... }:

{
  # Personal preference: dock hidden, no reveal delay.
  # Users with no hosts/<user>.nix keep macOS's own behaviour (dock visible).
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0;
  };

  homebrew = {
    taps = [
      "brucechanjianle/hyprmac"
    ];

    casks = [
      "brucechanjianle/hyprmac/hyprmac"
      "brave-browser"
      "foxglove"
      "keycastr"
      "obsidian"
      "zoom"
      "slack"
      "xquartz" # ssh -X
      "whatsapp"
      "microsoft-teams"
      "spotify"
    ];

    brews = [
      "cmake" "cppcheck" "glog" "libusb" "ccache" "wget"
        "tailscale" "pixi"
        "gcc" "tbb"
        "ffmpeg" "yt-dlp"
        "node" "ninja" "xcodegen"
    ];

    # "none" - leaves undeclared packages alone, so the list above is additive
    # "uninstall" - remove anything not declared (the declarative choice)
    # "zap"       - same, plus delete app data/config (destructive; only
    #               for a deliberate purge, not routine activation)
    onActivation = {
      cleanup = "zap";
    };
  };

  # Homebrew refuses to load casks from non-official taps until trusted.
  # Declared here so a fresh machine needs no manual `brew trust`.
  # Note: entries are NOT revoked by removing them - use `brew untrust`.
  nix-homebrew.trust.casks = [
    "brucechanjianle/hyprmac/hyprmac"
  ];

  # ---------------------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------------------
  home-manager.users.${user} = {
    home.packages = [
      pkgs.htop-vim
      pkgs.cmake-language-server
      pkgs.gdown
      pkgs.gh
      pkgs.git
    ];
  };
}
