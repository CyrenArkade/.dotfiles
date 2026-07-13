vim.keymap.set({'n', 'v', 'o', 'i'}, '<up>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<down>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<left>', '<nop>')
vim.keymap.set({'n', 'v', 'o', 'i'}, '<right>', '<nop>')
vim.keymap.set('n', '<space>', '<nop>')
vim.keymap.set('v', '<space>', '<nop>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { remap = true })
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d', { remap = true })
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')

