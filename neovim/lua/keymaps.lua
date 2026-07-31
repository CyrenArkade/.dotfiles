-- No arrows :p
vim.keymap.set({'n', 'v', 'o', 'i'}, '<up>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<down>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<left>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<right>', '<nop>')
vim.keymap.set('n', '<space>', '<nop>')
vim.keymap.set('v', '<space>', '<nop>')

-- Recenter when moving up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Paste at appropriate indent
vim.keymap.set('n', 'p', "p=']")
vim.keymap.set('n', 'P', "P=']")

-- System-level copy, cut, and paste
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { remap = true })
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d', { remap = true })
vim.keymap.set('n', '<leader>p', '"+p', { remap = true })
vim.keymap.set('n', '<leader>P', '"+P', { remap = true })

-- Navigate windows with ctrl+direction
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-l>', [[<C-\><C-n><C-w>l]])
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-k>', [[<C-\><C-n><C-w>k]])

-- Resize windows with ctrl+alt+direction
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-M-h>', '<Cmd>vertical resize -1<CR>')
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-M-l>', '<Cmd>vertical resize +1<CR>')
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-M-j>', '<Cmd>resize +1<CR>')
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<C-M-k>', '<Cmd>resize -1<CR>')

-- Move windows with ctrl+shift+direction
vim.keymap.set("n", "<C-S-h>", "<C-w>H")
vim.keymap.set("n", "<C-S-j>", "<C-w>J")
vim.keymap.set("n", "<C-S-k>", "<C-w>K")
vim.keymap.set("n", "<C-S-l>", "<C-w>L")

