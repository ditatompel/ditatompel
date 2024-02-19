local plugins = {
  -- this opts will extend the default opts
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      sync_root_with_cwd = true,
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "intelephense",
        "typescript-language-server",
        "svelte-language-server",
        "gopls",
        "goimports",
        "yaml-language-server",
        "rust-analyzer",
        "prettierd",
        "ltex-ls",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "go",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "php",
        "twig",
        "svelte",
        "c",
        "rust",
      },
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  { "wakatime/vim-wakatime", lazy = false },
  { "lambdalisue/suda.vim",  lazy = false },
}
return plugins
