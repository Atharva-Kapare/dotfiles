{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
    ];

    programs.nixvim.plugins.telescope = {
	    enable = true;

    };

    programs.nixvim.keymaps = [
        {
            key = "<leader>ff";
            action = ":Telescope find_files<cr>";
            options.desc = "Telescope Find Files";
        }
        {
            key = "<leader>fg"; 
            action = ":Telescope live_grep<cr>";
            options.desc = "Telescope Live Grep";
        }
        {
            key = "<leader>fb"; 
            action = ":Telescope buffers<cr>";
            options.desc = "Telescope Find Buffers";
        }
    ];
}
