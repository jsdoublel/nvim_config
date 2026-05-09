vim.pack.add({
  'https://github.com/slugbyte/lackluster.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
})

local lackluster = require('lackluster')
local color = lackluster.color
require('nvim-web-devicons').setup({
  color_icons = false,
  override = {
    ['default_icon'] = {
      color = color.gray4,
      name = 'Default',
    },
  },
})

lackluster.setup({
  tweak_syntax = {
    -- comment = color.gray5,
    -- string_escape = color.yellow,
  },
  tweak_background = {
    normal = 'none',
    telescope = 'none',
    menu = 'none',
    popup = 'none',
  },
  tweak_ui = {
    disable_undercurl = true,
    enable_end_of_buffer = true,
  },
})
vim.cmd.colorscheme('lackluster')

require('lualine').setup({
  options = {
    theme = 'lackluster',
  },
})
