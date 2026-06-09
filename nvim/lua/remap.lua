-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable some keybinds
vim.keymap.set('n', '<C-S-n>', '<Nop>', { noremap = true, desc = 'Disable Ctrl+Shift+n' })
vim.keymap.set('n', '<C-S-z>', '<Nop>', { noremap = true, desc = 'Disable Ctrl+Shift+z' })

vim.keymap.set('n', '<leader>ls', vim.cmd.Oil, { desc = 'Open file browser' })

-- Ctrl+d and Ctrl+u keep cursor centered (same for search)
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Copy to system clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to global clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to global clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank to global clipboard' })

-- Insert blank line
vim.keymap.set('n', '<leader>o', 'o<Esc>k')
vim.keymap.set('n', '<leader>O', 'O<Esc>j')

-- Replace remap
vim.keymap.set('n', '<leader>s', [[:%s/]], { desc = 'Begin search and replace' })

-- Spell check toggle
vim.keymap.set('n', '<leader>sp', function() vim.o.spell = not vim.o.spell end, { desc = 'Toggle spell checking' })

-- Toggle wordwrap
vim.keymap.set('n', '<leader>wr', function() vim.o.wrap = not vim.o.wrap end, { desc = 'Toggle word wrap' })

-- Tab through buffers
vim.keymap.set('n', '<Tab>', vim.cmd.bn, { desc = 'Advance to next buffer' })
vim.keymap.set('n', '<S-Tab>', vim.cmd.bp, { desc = 'Return to previous buffer' })
vim.keymap.set('n', '<leader>x', vim.cmd.bd, { desc = 'Delete current buffer' })

-- Move through panes
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- Update vim pack
vim.keymap.set('n', '<leader>up', vim.pack.update, { desc = 'Update plugins' })
vim.keymap.set('n', '<leader>m', vim.cmd.Mason, { desc = 'Open Mason' })
