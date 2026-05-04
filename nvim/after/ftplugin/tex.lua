vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.opt.expandtab = true

local function lint_file()
	require('lint').try_lint('codespell')
end

vim.api.nvim_create_autocmd({'BufReadPost', 'BufWinEnter', 'BufWritePost'}, {
	buffer = 0,
	callback = lint_file,
})
