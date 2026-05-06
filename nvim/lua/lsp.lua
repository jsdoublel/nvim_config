vim.pack.add({
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
	'https://github.com/saghen/blink.lib',
	'https://github.com/saghen/blink.cmp',
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
  keymap = {
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  fuzzy = {
    implementation = "rust",
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
		Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) }, },
	},
	clangd = {},
	gopls = {},
	pyright = {},
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = vim.tbl_keys(lsp_servers),
})

for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, {
		settings = config,
		-- only create the keymaps if the server attaches successfully
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "grd", vim.lsp.buf.definition,
				{ buffer = bufnr, desc = "vim.lsp.buf.definition()", })

			vim.keymap.set("n", "grf", vim.lsp.buf.format,
				{ buffer = bufnr, desc = "vim.lsp.buf.format()", })
		end,
	})
end

