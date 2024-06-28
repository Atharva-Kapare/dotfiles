{ config, pkgs, home-manager, ... }: {

    homeConfigurations = { 
        ak = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
            inherit userSettings;
            };
            modules = [ ./home.nix ];
        };
    };
}