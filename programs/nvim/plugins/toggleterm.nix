{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
  ];

  programs.nixvim.plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "float";
      closeOnExit = false;
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<esc>";
      action = "<C-\\><C-n>";
      mode = "t";
      options = {
        desc = "Exit Terminal";
      };
    }
    {
      key = "<leader>t";
      action = ":ToggleTerm<CR>";
      options = {
        desc = "Toggle a terminal";
      };
    }
  ];

  programs.nixvim.plugins.which-key = {
    settings = {
      spec = [
        {
          __unkeyed-1 = "<leader>t";
          desc = "Toggle terminal";
        }
      ];
    };
  };
}
