
{ config, pkgs, inputs, ...}: {
    # Configuration stuff ...
    imports = [
    ];

    programs.nixvim.plugins.lualine = {
	enable = true;
    };

}
