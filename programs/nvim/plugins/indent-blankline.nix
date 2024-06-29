{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins.indent-blankline = {
    enable = true;
  };
}
