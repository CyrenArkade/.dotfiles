local palette
Config.now(function()
  vim.pack.add({'https://github.com/catppuccin/nvim'})

  require('catppuccin').setup({
    transparent_background = true,
  })
  
  vim.cmd.colorscheme('catppuccin-mocha')
  palette = require('catppuccin.palettes').get_palette('mocha')
end)

Config.now(function()
  require('mini.misc').setup({})
  MiniMisc.setup_restore_cursor()
end)

Config.later(function()
  require('mini.pairs').setup({})
  require('mini.ai').setup({})
  require('mini.surround').setup({})
end)

Config.now(function()
  vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
  })

  require('lualine').setup({
    options = {
      theme = 'catppuccin-mocha',
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
  })
end)

Config.later(function()
  vim.pack.add({
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
  })

  local cmp = require('blink.cmp')
  cmp.build():pwait()
  cmp.setup({
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
  })
end)

Config.later(function()
  vim.pack.add({
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.indent',
  })

  require('blink.indent').setup({})
end)

Config.now(function()
  vim.pack.add({'https://github.com/mikavilpas/yazi.nvim'})

  vim.g.loaded_netrwPlugin = 1
  Config.on_event('UIEnter', function()
    require("yazi").setup({
      open_for_directories = true,
    })
    vim.keymap.set("n", "<leader>f", function() require("yazi").yazi() end)
  end)
end)

Config.later(function()
  vim.pack.add({'https://github.com/3rd/image.nvim'})

  require('image').setup({
    processor = "magick_cli",
  })
end)

Config.later(function()
  vim.pack.add({'https://github.com/folke/flash.nvim'})
  require('flash').setup({
    modes = {
      search = {
        enabled = true,
      },
    },
  })

  vim.keymap.set({'n', 'x', 'o'}, '<leader>s', function() require("flash").jump() end)
  vim.keymap.set({'n', 'x', 'o'}, '<leader>S', function() require("flash").treesitter() end)
  -- vim.keymap.set('c', '<C-s>', function() require("flash").toggle() end)
  vim.keymap.set('o', 'r', function() require("flash").remote() end)
  vim.keymap.set({'o', 'x'}, 'R', function() require("flash").treesitter_search() end)
end)

Config.now(function()
  Config.build('telescope-fzf-native.nvim', { 'install', 'update' }, function(data)
    vim.system({'make'}, { cwd = data.path })
  end)

  vim.pack.add {
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  }

  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  }
end)

Config.on_event('ModeChanged~*:[vV\22]', function()
  vim.pack.add({'https://github.com/mcauley-penney/visual-whitespace.nvim'})

  require('visual-whitespace').setup({
    vim.api.nvim_set_hl(0, "VisualNonText", { fg = palette.surface2 })
  })
end)

Config.later(function()
  vim.pack.add({'https://github.com/kawre/neotab.nvim'})

  require('neotab').setup({})
end)

