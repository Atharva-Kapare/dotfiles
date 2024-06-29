{ config, pkgs, inputs, ...}: 
let
    shellAliases = {
	nv = "nvim";
	gs = "git status";
	ga = "git add -p";
	gc = "git commit -m";
    };
in
{
    # Configuration stuff ...
    imports = [
    	# Import anything to do with the terminal here
    ];

    programs.bash.enable = true;
    programs.bash.shellAliases = shellAliases;
}
