{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
  };
}
