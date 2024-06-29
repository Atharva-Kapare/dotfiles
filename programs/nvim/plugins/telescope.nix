{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
    ];

    programs.nixvim.plugins.telescope = {
	enable = true;

	keymaps = {
	    "<leader>ff" = {
	    	action = "Telescope find_files";
		options.desc = "Telescope Find Files";
	    };
            "<leader>fg" = { 
	    	action = "Telescope live_grep";
		options.desc = "Telescope Live Grep";
	    };
            "<leader>fb" = { 
	    	action = "Telescope buffers";
		options.desc = "Telescope Find Buffers";
	    };
	};
    };

}
