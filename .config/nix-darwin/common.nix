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
      AppleShowAllExtensions = true;
      _HIHideMenuBar = false;
    };
    # dock.* is personal preference - set it in hosts/<user>.nix.
    finder.FXPreferredViewStyle = "Nlsv"; # list view by default
    finder.CreateDesktop = false; # no icons on the desktop
    trackpad.Clicking = true; # tap to click
    CustomUserPreferences = {
      # "com.apple.Safari" = {
      #   NSQuitAlwaysKeepsWindows = true;
      #   AlwaysRestoreSessionAtLaunch = true;
      # };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable 'Control + Space' to select the previous input source
          "60" = { enabled = false; };
          # Disable 'Control + Option + Space' to select the next input source
          "61" = { enabled = false; };
        };
      };
    };
  };

  # Use finger print for passwd inside terminal
  security.pam.services.sudo_local.touchIdAuth = true;
  # Optional: Fixes Touch ID inside tmux sessions
  security.pam.services.sudo_local.reattach = true;

  # homebrew packages
  homebrew = {
    enable = true;

    # Per-user extras live in hosts/<user>.nix; list options merge.
    casks = [
      "ghostty"
      "claude-code@latest"
    ];

    brews = [
      "ansible" "git"
      "neovim" "ripgrep" "fd" "luarocks" "imagemagick" "virtualenv"
      "tmux" "fzf"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none" - leaves undeclared packages alone, so the list above is additive
      # "uninstall" - remove anything not declared (the declarative choice)
      # "zap"       - same, plus delete app data/config (destructive; only
      #               for a deliberate purge, not routine activation)
      # mkDefault so a host can override in hosts/<user>.nix without conflict.
      cleanup = "none";
    };
  };

  # ---------------------------------------------------------------------
  # Home Manager - shared across all users.
  # Nested here because home-manager options are not system-level options.
  # ---------------------------------------------------------------------
  home-manager.users.${user} = {

    # Mandatory for every user, so it lives here rather than in
    # users/<user>.nix - those files are optional (lib.optional pathExists).
    home.stateVersion = "26.05";

    # Shared packages across all users
    home.packages = [
      pkgs.bat
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
