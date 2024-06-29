{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
    ];

    programs.nixvim.plugins.which-key = {
	enable = true;
    };

}
