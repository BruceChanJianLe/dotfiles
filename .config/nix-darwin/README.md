ostty 1.3.1   > Declarative macOS setup: system settings, Homebrew packages, and per-user
> dotfiles via home-manager. One flake, one entry per machine.

![img](https://github.com/user-attachments/assets/e762f8e8-4d76-47d1-8565-a4f275161834)

## Layout

```
flake.nix                           entry point, one entry per machine
flake.lock                          pinned input versions
common.nix                          config shared by every user
users/<user>.configuration.nix      per-user config (optional)
```

## Usage

| alias | command |
|-------|---------|
| `nd`  | `darwin-rebuild switch` - build and apply |
| `ndb` | `darwin-rebuild build` - build only, no changes |
| `ndl` | list generations |
| `ndr` | roll back to the previous generation |
| `ndu` | update flake inputs |

All of them target `#$USER`, so they pick the entry matching the current user.

## How it resolves

`nd` selects `darwinConfigurations.<user>`, which calls `mkHost { user }`.
That merges into a single config:

- `common.nix` (always)
- the `nix-homebrew` and `home-manager` modules (always)
- `users/<user>.configuration.nix` (only if the file exists)

`user` is passed through `specialArgs`, so any module can interpolate
`${user}`.

## Two layers, one file

`common.nix` and `users/<user>.configuration.nix` are both nix-darwin
modules:

```nix
{ config, pkgs, lib, user, ... }:
{
  homebrew.casks = [ ... ];           # system layer, top level
  system.defaults.dock.autohide = true;

  home-manager.users.${user} = {      # home-manager layer, nested
    home.packages = [ pkgs.gh ];
  };
}
```

System and home-manager are separate module systems. Nesting is what lets
one file carry both.

## Merge rules

- **Lists concatenate.** `casks`, `brews`, `taps` combine across files.
  No `mkMerge` needed.
- **Scalars conflict.** Defining `cleanup` or `dock.autohide` in two files
  is an evaluation error, not last-wins. Declare it in one place, or use
  `lib.mkDefault` in `common.nix` so a user file can override it.

## Adding a machine

Two edits, both required:

1. Create `users/<name>.configuration.nix`
2. Add `"<name>" = mkHost { user = "<name>"; };` to `darwinConfigurations`

## Gotchas

- **A missing user file is silent.** The import is
  `lib.optional (builtins.pathExists ...)`, so a misspelled filename gives
  a smaller config that still builds without warning. If a setting seems to
  have no effect, check the filename first.
- **Fully qualify third-party tap packages.** Write
  `"brucechanjianle/hyprmac/hyprmac"`, not `"hyprmac"`. When `cleanup` is
  `uninstall` or `zap`, `brew bundle cleanup --force` rebuilds Homebrew's
  trust store from the generated Brewfile and drops any short name, which
  wipes the trust written by `nix-homebrew.trust.casks` on every switch.
- **`cleanup = "zap"` deletes app data**, not just the packages.
  `"uninstall"` removes undeclared packages but leaves their data alone.
  Default is `"none"`.
- **Homebrew is not declarative.** nix generates a Brewfile and runs `brew`.
  Installed state and `~/.config/homebrew/trust.json` live outside nix.
