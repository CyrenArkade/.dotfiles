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

  require('mini.bufremove').setup({})
  vim.keymap.set({ 'n', 'v' }, '<leader>bd', function() MiniBufremove.delete() end)
  vim.keymap.set({ 'n', 'v' }, '<leader>bD', '<Cmd>bd<CR>')
  vim.keymap.set({ 'n', 'v' }, '<leader>bw', function() MiniBufremove.wipeout() end)
  vim.keymap.set({ 'n', 'v' }, '<leader>bW', '<Cmd>bw<CR>')

  require('mini.keymap').setup({})
  MiniKeymap.map_multistep('i', '<Tab>', { 'jump_after_close' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'jump_before_open' })
  MiniKeymap.map_multistep('i', '<CR>', { 'minipairs_cr' })
  MiniKeymap.map_multistep('i', '<S-CR>', { 'blink_accept' })
  MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

Config.later(function()
  vim.pack.add({'https://github.com/sh1Nome/mini-pick-preview.nvim'})

  function choose_all()
    local mappings = MiniPick.get_picker_opts().mappings
    vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
  end
  function pick_buffer()
    MiniPick.builtin.buffers({}, {
      mappings = {
        close_buffer = {
          char = '<C-d>',
          func = function()
            vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
            pick_buffer()
          end
        },
      },
    })
  end

  require('mini.pick').setup({
    window = { config = { width = 80 } },
    mappings = {
      choose_all = { char = '<C-q>', func = choose_all },
    },
  })
  require('mini.extra').setup({})
  require('mini-pick-preview').setup({})

  vim.keymap.set('n', '<leader>fb', pick_buffer)
  vim.keymap.set('n', '<leader>fB', '<Cmd>Pick gut_branches<CR>')
  vim.keymap.set('n', '<leader>fc', '<Cmd>Pick git_commits<CR>')
  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>')
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>')
  vim.keymap.set('n', '<leader>fk', '<Cmd>Pick keymaps<CR>')
  vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>')
  vim.keymap.set('n', '<leader>fs', '<Cmd>AutoSession search<CR>')
end)

Config.later(function()
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
      lualine_c = { { 'filename', symbols = { modified = '•︎' } } },
      lualine_x = { { 'lsp_status', symbols = { done = '✔' } } },
      lualine_y = { { 'filetype', padding = { left = 0, right = 1 } } },
      lualine_z = {
        { 'progress', separator = '', padding = 0 },
        { 'location', separator = { right = '' }, padding = 0 },
      }
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
    require("yazi").setup({})
    vim.keymap.set("n", "<leader>e", function() require("yazi").yazi() end)
  end)
end)

Config.now(function()
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
      paste = {
        default_animation = 'fade',
      },
    },
    animations = {
      fade = { to_color = palette.base }
    },
  })
end)

Config.later(function()
  vim.pack.add({'https://github.com/lewis6991/gitsigns.nvim'})

  require('gitsigns').setup({})
end)

Config.now(function()
  vim.pack.add({'https://github.com/luukvbaal/statuscol.nvim'})

  local builtin = require('statuscol.builtin')
  require('statuscol').setup({
    segments = {
      { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
      {
        sign = {
          text = { '.*' },
          maxwidth = 2,
          align = 'right',
        },
        click = 'v:lua.ScSa',
      },
      {
        text = { builtin.lnumfunc, ' ' },
        condition = { true, builtin.not_empty },
        click = 'v:lua.ScLa',
      },
    }
  })
end)

Config.now(function()
  Config.build('nvim-treesitter', { 'install', 'update', }, function(data)
    if not data.active then
      vim.cmd.packadd('nvim-treesitter')
    end
    vim.cmd('TSUpdate')
  end)

  vim.pack.add({'https://github.com/nvim-treesitter/nvim-treesitter'})

  require('nvim-treesitter').install({
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'fish',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'markdown',
    'nix',
    'python',
    'qmljs',
    'toml',
    'tsx',
    'typescript',
    'rust',
    'yaml',
  })
end)

Config.now(function()
  vim.pack.add({'https://github.com/rmagatti/auto-session'})

  vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
  require('auto-session').setup({
    bypass_save_filetypes = { 'toggleterm' },
    close_filetypes_on_save = { 'toggleterm' },
    auto_create = function()
      return vim.fn.argc() > 0
    end,
  })
end)

Config.later(function()
  vim.pack.add({'https://github.com/stevearc/oil.nvim'})

  require('oil').setup({
    delete_to_trash = true,
  })
  vim.keymap.set({ 'n', 'v' }, '<leader>o', '<Cmd>Oil --float<CR>')
end)

Config.later(function()
  vim.pack.add({'https://github.com/akinsho/toggleterm.nvim'})

  require('toggleterm').setup({})
  vim.keymap.set('n', '<leader>t', '<Cmd>ToggleTerm<CR>')
  vim.keymap.set('n', '<leader>T', '<Cmd>TermNew<CR>')
end)

Config.later(function()
  vim.pack.add({'https://github.com/NeogitOrg/neogit'})

  require('neogit')
  vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>')
end)

