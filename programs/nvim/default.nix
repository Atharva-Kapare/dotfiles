{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
        inputs.nixvim.homeManagerModules.nixvim # DO NOT REMOVE

	./plugins/hardtime.nix
    ];
    
    programs.nixvim = {
        enable = true;
        vimAlias = true;
	viAlias = true;
	defaultEditor = true;

        # Configure neovim options...
        opts = {
            relativenumber = true;
            incsearch = true;
        };
    };
}
