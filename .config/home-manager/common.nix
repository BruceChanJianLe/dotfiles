{ config, pkgs, ... }:

{
  # Shared packages across all users
  home.packages = [
    pkgs.neofetch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Ensures Home Manager has permission to write to the GNOME dconf database
  dconf.enable = true;

  dconf.settings = {
    # 1. Register your two custom keybinding profile paths
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    # 2. Define the 'Ghostty' shortcut
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Ghostty";
      command = "ghostty";
      binding = "<Super>Return";
    };
  };
}
