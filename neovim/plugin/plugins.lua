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
  require('mini.move').setup({})
  require('mini.splitjoin').setup({})

  require('mini.keymap').setup({})
  MiniKeymap.map_multistep('i', '<Tab>', { 'jump_after_tsnode' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'jump_before_tsnode' })
  MiniKeymap.map_multistep('i', '<CR>', { 'minipairs_cr' })
  MiniKeymap.map_multistep('i', '<S-CR>', { 'blink_accept' })
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

Config.later(function()
  vim.pack.add({'https://github.com/sh1Nome/mini-pick-preview.nvim'})

  require('mini.pick').setup({
    window = { config = { width = 80 } }
  })
  require('mini.extra').setup({})
  require('mini-pick-preview').setup({})

  vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>')
  vim.keymap.set('n', '<leader>fB', '<Cmd>Pick gut_branches<CR>')
  vim.keymap.set('n', '<leader>fc', '<Cmd>Pick git_commits<CR>')
  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>')
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>')
  vim.keymap.set('n', '<leader>fk', '<Cmd>Pick keymaps<CR>')
  vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>')
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
  vim.pack.add({'https://github.com/neovim/nvim-lspconfig'})
  require('lsps')
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
  vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/mikavilpas/yazi.nvim',
  })

  vim.g.loaded_netrwPlugin = 1
  Config.on_event('UIEnter', function()
    require("yazi").setup({
      open_for_directories = true,
    })
    vim.keymap.set("n", "<leader>t", function() require("yazi").yazi() end)
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
  require('flash').setup({})

  vim.keymap.set({'n', 'x', 'o'}, '<leader>s', function() require("flash").jump() end)
  vim.keymap.set({'n', 'x', 'o'}, '<leader>S', function() require("flash").treesitter() end)
  -- vim.keymap.set('c', '<C-s>', function() require("flash").toggle() end)
  vim.keymap.set('o', 'r', function() require("flash").remote() end)
  vim.keymap.set({'o', 'x'}, 'R', function() require("flash").treesitter_search() end)
end)

Config.later(function()
  Config.build('fff', { 'install', 'update', }, function(data)
    if not data.active then
      vim.cmd.packadd('fff')
    end
    require('fff.download').download_or_build_binary()
  end)

  vim.pack.add({'https://github.com/dmtrKovalenko/fff'})

  vim.g.fff = {
    lazy_sync = true,
    debug = { enabled = true, show_scores = true },
  }

  vim.keymap.set('n', '<leader>wf', function() require('fff').find_files() end)
end)

Config.on_event('ModeChanged~*:[vV\22]', function()
  vim.pack.add({'https://github.com/mcauley-penney/visual-whitespace.nvim'})

  require('visual-whitespace').setup({
    vim.api.nvim_set_hl(0, "VisualNonText", { fg = palette.subtext0, bg = palette.surface1 })
  })
end)

Config.later(function()
  vim.pack.add({'https://github.com/rachartier/tiny-glimmer.nvim'})

  require("tiny-glimmer").setup({
    overwrite = {
      paste = { default_animation = 'fade' },
    },
    animations = {
      fade = { to_color = palette.base }
    },
  })
end)

