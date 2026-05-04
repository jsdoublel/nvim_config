local function lint_file()
	local lint = require('lint')
	lint.try_lint()
	lint.try_lint('codespell')
end

local function format_file()
	vim.cmd('silent! !gofmt -w %')
end

vim.api.nvim_create_autocmd({'BufWritePost'}, {
	buffer = 0,
	callback = function ()
		lint_file()
		format_file()
	end
})

vim.api.nvim_create_autocmd({'BufReadPost', 'BufWinEnter'}, {
	buffer = 0,
	callback = lint_file,
})
