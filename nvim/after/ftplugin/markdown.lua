local function compile_markdown()
	local pdf_name = vim.fn.expand('%'):gsub("%.md$", ".pdf")
	local md_name = vim.fn.expand('%')
	vim.cmd.w()
	vim.cmd(('silent! !pandoc %s -o %s -V geometry:margin=0.75in'):format(md_name, pdf_name))
	-- open zathura if zathura doesn't already have pdf file open
	vim.cmd(('silent! !zathura --synctex-forward :: %s > /dev/null &'):format(pdf_name))
end

vim.keymap.set("n", "<leader>c", compile_markdown)
-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	callback = compile_markdown,
-- })
