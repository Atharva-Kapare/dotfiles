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
    none-ls = {
      enable = true;
      enableLspFormat = true;
      settings.update_in_insert = false;
      sources = {
        code_actions = {
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          yamllint.enable = true;
        };
        formatting = {
          alejandra.enable = true; # Nix formatter
          black = {
            # Python formatter
            enable = true;
            withArgs = ''
              {
                  extra_args = { "--fast" },
              }
            '';
          };
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
            withArgs = ''
              {
                  extra_args = { "--no-semi", "--single-quote" },
              }
            '';
          };
          stylua.enable = true;
          yamlfmt.enable = true;
        };
      };
    };

    lsp-format.enable = true;
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        nixd.enable = true;
        html.enable = true;
        htmx.enable = true;
        # tsserver.enable = true;
        eslint.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    lsp-lines = {
      enable = true;
      currentLine = true;
    };

    trouble.enable = true;

    fidget = {
      enable = true;
      progress = {
        suppressOnInsert = true;
        ignoreDoneAlready = true;
        pollRate = 0.5;
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>fc";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format Code";
      };
    }
  ];
}
