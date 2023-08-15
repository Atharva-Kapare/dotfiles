print 'hello from plugins'

local plugins = {
  {
    'neovim/nvim-lspconfig',
    config = function ()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua"
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",

       -- low level
        "c",
        "zig"
      },
    },
  },
}
return plugins
