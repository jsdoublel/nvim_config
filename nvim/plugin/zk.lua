vim.pack.add({ 'https://github.com/zk-org/zk-nvim' })

require('zk').setup({
  picker = 'telescope',
  picker_options = {
    telescope = require('telescope.themes').get_ivy(),
  },
})

local opts = { noremap = true, silent = false }

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap(
  'n',
  '<leader>zs',
  "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
  opts
)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap('v', '<leader>zs', ":'<,'>ZkMatch<CR>", opts)
