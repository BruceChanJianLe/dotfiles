# System-level overrides for the `developer` host.
# Merged on top of ../configuration.nix - list options concatenate, so this
# file only needs to carry the delta.
{ ... }:

{
  # Personal preference: dock hidden, no reveal delay.
  # Users with no hosts/<user>.nix keep macOS's own behaviour (dock visible).
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0;
  };

  homebrew.taps = [
    "brucechanjianle/hyprmac"
  ];

  homebrew.casks = [
    "hyprmac"
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

  homebrew.brews = [
    "cmake" "cppcheck" "glog" "libusb" "ccache" "wget"
    "tailscale" "pixi"
    "gcc" "tbb"
    "ffmpeg" "yt-dlp"
    "node" "ninja" "xcodegen"
  ];

  # Homebrew refuses to load casks from non-official taps until trusted.
  # Declared here so a fresh machine needs no manual `brew trust`.
  # Note: entries are NOT revoked by removing them - use `brew untrust`.
  nix-homebrew.trust.casks = [
    "brucechanjianle/hyprmac/hyprmac"
  ];
}
