-- nvim settings
-- line numbers
vim.o.nu = true
vim.o.relativenumber = true
-- very normal configuration line for turning on line numbers in netrw
-- I actually do know what all these words mean and total did not copy this 
-- from somewhere
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'


-- 4 space tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- vim.opt.expandtab = true 

-- expand undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- highlight as you search
vim.o.hlsearch = true
vim.o.incsearch = true

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- enable more colors in vim
vim.o.termguicolors = true

-- enable vertical bar
vim.o.colorcolumn = "80,120"

-- keep curser away from top/bottom of screen when scrolling
vim.o.scrolloff = 5

