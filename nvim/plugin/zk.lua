vim.pack.add({ 'https://github.com/zk-org/zk-nvim' })

require('zk').setup({
  picker = 'telescope',
  picker_options = {
    telescope = require('telescope.themes').get_ivy(),
  },
})

vim.keymap.set('n', '<leader>zn', function()
  local title = vim.fn.input('Title: ')
  if string.len(title) ~= 0 then vim.cmd("ZkNew { title = '" .. title .. "' }") end
end, { desc = 'Create new note' })

vim.keymap.set(
  'n',
  '<leader>zd',
  function() vim.cmd("ZkNew { dir = 'daily' }") end,
  { desc = 'Create/Open daily journal' }
)

vim.keymap.set('n', '<leader>zf', function() vim.cmd.ZkNotes() end, { desc = 'Find note' })
vim.keymap.set('n', '<leader>zt', function() vim.cmd.ZkTags() end, { desc = 'Search note tags' })

vim.keymap.set('n', '<leader>zs', function()
  local search = vim.fn.input('Search: ')
  if string.len(search) ~= 0 then vim.cmd("ZkNotes { sort = { 'modified' }, match = { '" .. search .. "' } }") end
end, { desc = 'Search notes (normal mode)' })

vim.keymap.set('v', '<leader>zs', ":'<,'>ZkMatch<CR>", { desc = 'Search notes (visual mode)' })
vim.keymap.set('n', '<leader>zb', function() vim.cmd.ZkBacklinks() end, { desc = 'Show backlinks to current buffer' })
vim.keymap.set('n', '<leader>zl', function() vim.cmd.ZkLinks() end, { desc = 'Show backlinks to current buffer' })
