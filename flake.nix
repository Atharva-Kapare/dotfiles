{
  description = "Home Manager configuration of ak";

  outputs = { self, nixpkgs, home-manager, ... }@inputs :
    let

systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "white-dwarf"; # hostname
      };

      userSettings = rec {
        username = "ak";
        email = "atharva.s.kapare@gmail.com"; #Used by some configurations, like git
        
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      
      homeConfigurations = { 
	ak = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          #estraspecialArgs = {
          #  inherit userSettings;
          #};
          modules = [ ./home.nix ];
        };
      };

      nixosConfigurations = {
        white-dwarf = nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./configuration.nix
          ]; # load configuration.nix from selected PROFILE
          specialArgs = {
            # pass config variables from above
            inherit pkgs;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
      }; 
    };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
