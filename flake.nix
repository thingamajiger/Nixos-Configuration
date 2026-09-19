{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/efb50993780079460b0cbed1363e2166a2de1d9f9";
  };

  outputs = { self, nixpkgs, spicetify-nix, millennium, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration.nix

        {
          nixpkgs.overlays = [
            millennium.overlays.default
          ];
        }

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            extraSpecialArgs = {
              inherit inputs;
            };

            users.tmajig = import ./main.nix;
          };
        }
      ];
    };
  };
}
