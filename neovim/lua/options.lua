vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ===== UI =====
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes:2'
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  fold = " ",
}

vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars = 'tab:↦ ,trail:·,nbsp:␣'

-- ===== Misc =====
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.undofile = true
vim.opt.switchbuf = 'usetab'
vim.opt.shell = 'fish'
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set up automatic folding
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Enable LSP-based folding if supported',
  callback = function(ev)
    local bufnr = ev.buf
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/foldingRange', bufnr) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

