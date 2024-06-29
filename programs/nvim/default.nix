{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
        inputs.nixvim.homeManagerModules.nixvim # DO NOT REMOVE

	# ./plugins/hardtime.nix
	./plugins/which-key.nix
	./plugins/lualine.nix
    ];
    
    programs.nixvim = {
        enable = true;
        vimAlias = true;
	viAlias = true;
	defaultEditor = true;

	globals.mapleader = " ";

        # Configure neovim options...
        opts = {
            relativenumber = true;
            incsearch = true;
        };
    };
}
