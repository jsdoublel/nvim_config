vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/stevearc/conform.nvim',
})

local blink = require('blink.cmp')
blink.build():wait(60000)
blink.setup({
  completion = {
    menu = { border = 'rounded' },
    documentation = {
      auto_show = true,
      window = { border = 'rounded' },
    },
  },
  signature = { enabled = false },
  keymap = {
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  fuzzy = {
    implementation = 'rust',
  },
})

-- Custom border colors for blink.cmp
vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#444444', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = '#444444', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BlinkCmpDocSeparator', { fg = '#444444', bg = 'NONE' })

local lsp_servers = {
  lua_ls = {
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file('lua', true) } },
  },
  clangd = {},
  gopls = {},
  pyright = {},
}

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,
    -- only create the keymaps if the server attaches successfully
    on_attach = function(_, bufnr)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'vim.lsp.buf.definition()' })
      vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = bufnr, desc = 'vim.lsp.buf.format()' })
    end,
  })
end

-- Attach treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end
    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)
  end,
})

-- Set up linting
local lint = require('lint')
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  go = { 'golangcilint' },
}
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint('codespell')
      lint.try_lint()
    end
  end,
})

-- set up autoformatting
local conform = require('conform')
conform.formatters_by_ft = {
  lua = { 'stylua' },
  go = { 'gofmt' },
  python = { 'black' },
  cpp = { 'clang-format' },
}
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args) conform.format({ bufnr = args.buf }) end,
})
