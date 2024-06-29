{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins.hardtime = {
    enable = true;
  };
}
