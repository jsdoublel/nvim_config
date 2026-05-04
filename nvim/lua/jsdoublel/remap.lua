-- key remappings for nvim; focus output primary
-- leader key
vim.g.mapleader = " "

-- pull up files
vim.keymap.set("n", "<leader>ls", vim.cmd.Ex)

-- packer sync and other helpful such keybindings
vim.keymap.set("n", "<leader>psy", vim.cmd.PackerSync)
-- vim.keymap.set("n", "<leader>tt", vim.cmd.TransparentToggle)

-- save/save and quit
-- vim.keymap.set("n", "<leader>w", vim.cmd.w)
-- vim.keymap.set("n", "<leader>wq", vim.cmd.wq)
-- vim.keymap.set("n", "<leader>q", vim.cmd.q)

-- move paragraphs in visual mode
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- for indenting it is > and < by default which is fine
--
vim.keymap.set("n", "<leader>w", function ()
	vim.diagnostic.setqflist({
		open = true,
		title = "Diagnostics",
	})
end)

-- Ctrl+d and Ctrl+u keep cursor centered (same for search)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- insert blank line
vim.keymap.set("n", "<leader>o", "o<Esc>k")
vim.keymap.set("n", "<leader>O", "O<Esc>j")

-- replace remap 
vim.keymap.set("n", "<leader>s", [[:%s/]])

-- spell check toggle
vim.keymap.set('n', '<leader>sp', function()
  vim.o.spell = not vim.o.spell
end)

-- toggle wordwrap
vim.keymap.set("n", '<leader>wr', function()
    vim.o.wrap = not vim.o.wrap
end)

-- tab through buffers
vim.keymap.set('n', '<Tab>', vim.cmd.bn)
vim.keymap.set('n', '<S-Tab>', vim.cmd.bp)

-- set pyright to correct venv 
vim.keymap.set('n', '<leader>py', function()
    local pypath = io.popen("which python"):read("*a"):gsub("%s+", "")
    vim.cmd.PyrightSetPythonPath(pypath)
    print("Pyright python path set to:", pypath)
end)

-- terminal mode remaps
vim.keymap.set('n', '<leader>t', function ()
	vim.cmd.terminal()
end)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

local visual_replace = require('jsdoublel.visual_replace')

vim.keymap.set('x', '<leader>,', function()
  visual_replace.run_visual_eval(visual_replace.outermost_commas_transform)
end, { desc = 'mini.operators: newline outer commas' })
