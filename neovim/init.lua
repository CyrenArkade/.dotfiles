local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({'n', 'v', 'o', 'i'}, '<Up>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<Down>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<Left>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<Right>', '<nop>')

require("lazy").setup("plugins")
