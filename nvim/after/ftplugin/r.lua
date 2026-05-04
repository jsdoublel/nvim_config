vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.opt.expandtab = true

local function format_on_save()
	vim.cmd('silent! !air format %')
end

vim.api.nvim_create_autocmd('BufWritePost', {
	callback = format_on_save,
})
