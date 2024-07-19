{
  description = "Home Manager configuration of ak";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "white-dwarf"; # hostname
      profile = "personal";
      device = "desktop";
    };

    userSettings = rec {
      username = "ak";
      email = "atharva.s.kapare@gmail.com"; #Used by some configurations, like git
    };

    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };
  in {
    # imports = [
    #   ./profiles/personal # (2)
    # ];

    homeConfigurations =
      nixpkgs.lib.genAttrs ["ak"]
      (username:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit userSettings;
            inherit inputs;
          };
          modules = [
            ./users/${username}/home.nix
          ];
        });

    nixosConfigurations =
      nixpkgs.lib.genAttrs ["white-dwarf" "red-giant" "pandora"]
      (hostName:
        nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            {networking.hostName = hostName;}
            ./device/${hostName}/configuration.nix
          ];
          specialArgs = {
            # pass config variables from above
            inherit pkgs;
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        });
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
