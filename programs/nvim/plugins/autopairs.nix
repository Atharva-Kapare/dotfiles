{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins.autopairs = {
    enable = true;
  };
}
