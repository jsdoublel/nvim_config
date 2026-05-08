vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines
	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})

vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float, { desc = "Open diagnostic float on line" })
vim.keymap.set("n", "<leader>ww", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })
