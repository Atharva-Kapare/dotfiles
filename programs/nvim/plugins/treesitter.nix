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
      settings = {
        incrementalSelection.enable = true;
        nixGrammars = true;
        indent.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = {max_lines = 2;};
    };
    treesitter-refactor = {
      enable = true;

      settings.navigation = {
        enable = true;
      };
    };
    rainbow-delimiters.enable = true;
  };
}
