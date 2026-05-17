vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local splitjoin = require('mini.splitjoin')
splitjoin.setup({
  mappings = {
    toggle = 'g,',
    split = '',
    join = '',
  },
  split = {
    hooks_post = { splitjoin.gen_hook.add_trailing_separator(splitjoin.config.brackets) },
  },
  join = {
    hooks_post = { splitjoin.gen_hook.del_trailing_separator(splitjoin.config.brackets) },
  },
})

require('mini.surround').setup({
  mappings = {
    add = 'sa',
    delete = 'sd',
    find = 'sf',
    find_left = 'sF',
    highlight = 'sh',
    replace = 'sr',
    suffix_last = 'l',
    suffix_next = 'n',
  },
  custom_surroundings = { -- helpful for markdown
    b = {
      input = { '%*%*().-()%*%*' },
      output = { left = '**', right = '**' },
    },
    i = {
      input = { '%*().-()%*' },
      output = { left = '*', right = '*' },
    },
  },
})
