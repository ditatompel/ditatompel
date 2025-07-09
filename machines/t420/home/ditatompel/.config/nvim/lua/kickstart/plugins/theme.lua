return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- make sure to load this before all the other start plugins.
    init = function()
      -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      vim.cmd.colorscheme 'catppuccin-mocha'

      --    -- You can configure highlights by doing something like:
      --    vim.cmd.hi 'Comment gui=none'
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
