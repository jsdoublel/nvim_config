-- require 'nordic' .setup {
--     -- This callback can be used to override the colors used in the palette.
--     on_palette = function(palette) return palette end,
--     -- Enable bold keywords.
--     bold_keywords = true,
--     -- Enable italic comments.
--     italic_comments = true,
--     -- Enable general editor background transparency.
--     transparent = {
-- 		bg = true,
-- 		float = true,
-- 	},
--     -- Enable brighter float border.
--     bright_border = true,
--     -- Reduce the overall amount of blue in the theme (diverges from base Nord).
--     reduced_blue = true,
--     -- Swap the dark background with the normal one.
--     swap_backgrounds = true,
--     -- Override the styling of any highlight group.
-- 	on_highlight = function (highlight, palette)
-- 		highlight.StatusLine = {fg = 'black', bg = 'grey'}
-- 		highlight.StatusLineNC = {fg = 'grey', bg = 'black'}
-- 		highlight.LineNrAbove = {fg = 'grey', bold = false}
-- 		highlight.LineNr = {fg = '#5E81AC', bold = true}
-- 		highlight.LineNrBelow = {fg = 'white', bold = false}
-- 	end,
--     -- Cursorline options.  Also includes visual/selection.
--     cursorline = {
--         -- Bold font in cursorline.
--         bold = false,
--         -- Bold cursorline number.
--         bold_number = true,
--         -- Avialable styles: 'dark', 'light'.
--         theme = 'light',
--         -- Blending the cursorline bg with the buffer bg.
--         blend = 0.85,
--     },
--     ts_context = {
--         -- Enables dark background for treesitter-context window
--         dark_background = true,
--     },
--     telescope = {
--         -- Available styles: `classic`, `flat`.
--         style = 'classic',
--     }
-- }
-- vim.cmd.colorscheme 'nordic'

-- vim.g.rams_transp_bp = 1
-- vim.g.rams_transp_bg = 1
 -- Optional, you don't have to run setup.
-- require("transparent").setup({
--   -- table: default groups
--   groups = {
--     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
--     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
--     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
--     'SignColumn', 'CursorLine', 'CursorLineNr',
--     'EndOfBuffer',
--   },
--   -- table: additional groups that should be cleared
--   extra_groups = {},
--   -- table: groups you don't want to clear
--   exclude_groups = {'StatusLine', 'StatusLineNC',},
--   -- function: code to be executed after highlight groups are cleared
--   -- Also the user event "TransparentClear" will be triggered
--   on_clear = function() end,
-- })
-- vim.g.monochrome_italic_comments = 0
-- vim.cmd.colorscheme 'monochrome'
-- vim.cmd.colorscheme 'rams'
-- vim.cmd.colorscheme 'candle-grey-transparent'

-- -- lackluster
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


-- vim.cmd.colorscheme 'monoglow'
-- require("monoglow").setup({
--   -- Change the "glow" color
--   on_colors = function(colors)
--     colors.glow = "#ff00000"
--   end
-- })

-- require('black-metal').setup({
-- 	theme = "impaled-nazarene",
-- 	variant = "dark",
-- 	transparent = "true",
-- })
-- require('black-metal').load()

-- Make floating windows transparent (hover/signature/diagnostic, etc.)
-- Adjust or remove if you prefer opaque floats.
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
-- Optionally make completion menu transparent as well
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = 'NONE' })
