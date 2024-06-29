{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
    ];

    programs.nixvim.plugins.telescope = {
	enable = true;
    };

}
