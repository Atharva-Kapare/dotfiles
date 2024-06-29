{ config, pkgs, inputs, ...}: 
{
    # Configuration stuff ...
    imports = [
    	# Import anything to do with the terminal here
	../shell
    ];

    home.packages = [
	pkgs.alacritty
    ];

    programs.alacritty = {
        enable = true;
    };
}
