return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
      -- auto_integrations = true,
    },
    init = function()
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'catppuccin-nvim',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' } } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' } } }
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('ruff')
      vim.lsp.enable('rust_analyzer')
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
    },
    build = function()
      require('blink.cmp').build():pwait()
    end,
  }
}