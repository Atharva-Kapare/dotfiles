{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
    inputs.nixvim.homeManagerModules.nixvim # DO NOT REMOVE

    # ./plugins/hardtime.nix
    ./plugins/which-key.nix
    ./plugins/lualine.nix
    ./plugins/telescope.nix
    ./plugins/toggleterm.nix
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
    ./plugins/git.nix
    ./plugins/autopairs.nix
    ./plugins/indent-blankline.nix
    ./plugins/precognition.nix
    ./plugins/no-neck-pain.nix
    ./plugins/cmp.nix
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;

    colorschemes = {
      cyberdream = {
        enable = true;
      };
    };

    globals.mapleader = " ";

    keymaps = [
      {
        key = "<C-h>";
        action = "<Cmd>wincmd h<CR>";
      }
      {
        key = "<C-j>";
        action = "<Cmd>wincmd j<CR>";
      }
      {
        key = "<C-k>";
        action = "<Cmd>wincmd k<CR>";
      }
      {
        key = "<C-l>";
        action = "<Cmd>wincmd l<CR>";
      }
    ];

    # Configure neovim options...
    opts = {
      relativenumber = true;
      incsearch = true;
      expandtab = true;
      shiftwidth = 4;
      smartindent = true;
      tabstop = 4;
    };
  };
}
