{
  description = "Home Manager configuration of dev";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Single user
  # outputs =
  #   { nixpkgs, home-manager, ... }:
  #   let
  #     system = "x86_64-linux";
  #     pkgs = nixpkgs.legacyPackages.${system};
  #   in
  #   {
  #     homeConfigurations."developer" = home-manager.lib.homeManagerConfiguration {
  #       inherit pkgs;
  #
  #       # Specify your home configuration modules here, for example,
  #       # the path to your home.nix.
  #       modules = [ ./home.nix ];
  #
  #       # Optionally use extraSpecialArgs
  #       # to pass through arguments to home.nix
  #     };
  #   };

    outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkUser = username: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./common.nix
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
          # User-specific config if it exists
          (if builtins.pathExists ./users/${username}.nix 
           then ./users/${username}.nix 
           else {})
        ];
      };
    in
    {
      homeConfigurations = {
        "chanjl" = mkUser "chanjl";
        "brina" = mkUser "brina";
        "developer" = mkUser "developer";
      };
    };
}
