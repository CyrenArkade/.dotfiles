vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

Config = {}

Config.autocmd = function(events, pattern, callback)
  local opts = { pattern = pattern, callback = callback, once = true }
  vim.api.nvim_create_autocmd(events, opts)
end

Config.build = function(plugin_name, kinds, callback)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
      return
    end
    if not ev.data.active then
      vim.cmd.packadd(plugin_name)
    end
    callback(ev.data)
  end
  Config.autocmd('PackChanged', '*', f)
end

vim.pack.add({'https://github.com/nvim-mini/mini.nvim'})

local misc = require('mini.misc')
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

-- Better scrolloff
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
    callback = function()
        local win_h = vim.api.nvim_win_get_height(0)
        local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
        local dist = vim.fn.line "$" - vim.fn.line "."
        local rem = vim.fn.line "w$" - vim.fn.line "w0" + 1
        if dist < off and win_h - rem + dist < off then
            local view = vim.fn.winsaveview()
            view.topline = view.topline + off - (win_h - rem + dist)
            vim.fn.winrestview(view)
        end
    end,
})

-- Automatically enable treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require('options')
require('keymaps')

