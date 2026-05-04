vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.expandtab = true

local function lint_file()
	require('lint').try_lint('codespell')
end

local function format_on_save()
	vim.cmd('silent! !black %')
end

vim.api.nvim_create_autocmd({'BufReadPost', 'BufWinEnter'}, {
	buffer = 0,
	callback = lint_file,
})

vim.api.nvim_create_autocmd('BufWritePost', {
	buffer = 0,
	callback = function ()
		lint_file()
		format_on_save()
	end
})
