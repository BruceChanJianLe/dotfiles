{ config, pkgs, lib, user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  # Opt in per-package instead of blanket-allowing unfree licences.
  nixpkgs.config.allowUnfree = false;

  system.primaryUser = user;
  system.stateVersion = 6;

  programs.zsh.enable = true;

  # macOS preferences, declared rather than clicked through System Settings.
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2; # faster than the System Settings slider allows
      InitialKeyRepeat = 15; # short delay before repeat kicks in
      _HIHideMenuBar = true; # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv"; # list view by default
    finder.CreateDesktop = false; # no icons on the desktop
    trackpad.Clicking = true; # tap to click
  };

  # homebrew packages
  homebrew = {
    enable = true;

    # GUI apps stay casks: nix cannot produce a working /Applications bundle.
    casks = [
      "ghostty"
      "brave-browser"
    ];

    brews = [
      "ansible" "cmake" "cppcheck" "glog" "libusb" "ccache" "wget"
      "neovim" "ripgrep" "fd" "luarocks" "imagemagick" "virtualenv"
      "tmux"
      "fzf"
      "herdr"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none" - leaves undeclared packages alone, so the list above is additive
      # "uninstall" - remove anything not declared (the declarative choice)
      # "zap"       - same, plus delete app data/config (destructive; only
      #               for a deliberate purge, not routine activation)
      cleanup = "none";
    };
  };
}
