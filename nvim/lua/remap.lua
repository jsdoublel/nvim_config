-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>ls", vim.cmd.Ex)

-- Ctrl+d and Ctrl+u keep cursor centered (same for search)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- insert blank line
vim.keymap.set("n", "<leader>o", "o<Esc>k")
vim.keymap.set("n", "<leader>O", "O<Esc>j")

-- replace remap
vim.keymap.set("n", "<leader>s", [[:%s/]])

-- spell check toggle
vim.keymap.set("n", "<leader>sp", function()
	vim.o.spell = not vim.o.spell
end)

-- toggle wordwrap
vim.keymap.set("n", "<leader>wr", function()
	vim.o.wrap = not vim.o.wrap
end)

-- tab through buffers
vim.keymap.set("n", "<Tab>", vim.cmd.bn)
vim.keymap.set("n", "<S-Tab>", vim.cmd.bp)

-- update vim pack
vim.keymap.set("n", "<leader>up", vim.pack.update)
