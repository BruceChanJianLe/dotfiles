{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{ self, nix-darwin, nix-homebrew, home-manager, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      mkHost =
        { user
        , system ? "aarch64-darwin"
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit user; };

          modules = [
            ./configuration.nix
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager

            {
              nixpkgs.hostPlatform = system;

              users.users.${user} = {
                name = user;
                home = "/Users/${user}";
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit user; };

                users.${user}.imports = [
                  ./common.nix
                ]
                ++ lib.optional (builtins.pathExists ./users/${user}.nix)
                                ./users/${user}.nix;
              };

              nix-homebrew = {
                enable = true;
                inherit user;          # owns the /opt/homebrew prefix
                enableRosetta = false;
              };
            }
          ];
        };
    in
    {
      # One entry per laptop. Switch with:
      # darwin-rebuild switch --flake ~/.config/nix-darwin#developer
      darwinConfigurations = {
        "developer" = mkHost { user = "developer"; };
        "chanjl" = mkHost { user = "chanjl"; };
      };
    };
}
