vim.pack.add({'https://github.com/slugbyte/lackluster.nvim'})

local lackluster = require('lackluster')
-- local color = lackluster.color
lackluster.setup({
	tweak_syntax = {
		-- comment = color.yellow
	},
	tweak_background = {
		normal = 'none',
		telescope = 'none'
	},
	tweak_ui = {
		disable_undercurl = true,
		enable_end_of_buffer = true
	}
})
vim.cmd.colorscheme 'lackluster'
require('lualine').setup({
  options = {
    theme = "lackluster",
  },
})

