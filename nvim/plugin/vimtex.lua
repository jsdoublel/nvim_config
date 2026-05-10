vim.pack.add({ 'https://github.com/lervag/vimtex' })

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_enabled = 0 -- use vimtex syntax highlighting instead of treesitter

vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_autoclose = 1

-- -- autocmd to automatically snap pdf to cursor
-- vim.api.nvim_create_autocmd('CursorHold', {
--   pattern = '*.tex',
--   group = vim.api.nvim_create_augroup('VimTexForwardSearch', { clear = true }),
--   callback = function()
--     if vim.b.vimtex ~= nil then vim.cmd('VimtexView') end
--   end,
-- })
