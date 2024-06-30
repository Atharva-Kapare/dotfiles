{
  config,
  pkgs,
  inputs,
  ...
}: let
  shellAliases = {
    nv = "nvim";
    gs = "git status";
    ga = "git add -p";
    gc = "git commit -m";
    la = "ls -la";
    t = "tmux";
    lg = "lazygit";
    cat = "bat";
  };
in {
  # Configuration stuff ...
  imports = [
    # Import anything to do with the terminal here
  ];

  home.packages = [
    pkgs.tmux
    pkgs.bat
  ];

  programs.tmux.enable = true;

  # programs.zsh.enable = true;
  # programs.zsh.shellAliases = shellAliases;
  programs.bash.enable = true;
  programs.bash.shellAliases = shellAliases;
}
