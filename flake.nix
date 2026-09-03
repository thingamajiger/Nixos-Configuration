{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  users.tmajig = import ./main.nix;
};
        }
      ];
    };
  };
}
