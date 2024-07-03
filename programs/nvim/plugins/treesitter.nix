{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixGrammars = true;
      indent = true;
      incrementalSelection.enable = true;
    };
    treesitter-context = {
      enable = true;
      settings = {max_lines = 2;};
    };
    treesitter-refactor = {
      enable = true;

      navigation = {
        enable = true;
      };
    };
    rainbow-delimiters.enable = true;
  };
}
