local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


vim.lsp.config('lua_ls', {
-- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        -- Recognize these globals when editing your Neovim config
        globals = { 'vim', 'require' },
      },
      workspace = {
        -- Avoid slow, massive scans of your entire runtimepath
        -- (see note below)
        checkThirdParty = false,
        -- Keep it light but useful: Neovim runtime + your config dir
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('config'),
        },
      },
      -- telemetry = { enable = false },
    },
  },
})

-- Enable the server (after defining/overriding its config)
vim.lsp.enable('lua_ls')

require('mason').setup({})
require('mason-lspconfig').setup({
	automatic_installation = false,
	ensure_installed = {"pyright", "lua_ls"},
	handlers = {
		lsp_zero.default_setup,
	},
})
local cmp_action = lsp_zero.cmp_action()
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  window = {
    completion = cmp.config.window.bordered({
      border = 'single',
    }),
    documentation = cmp.config.window.bordered({
      border = 'single',
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    -- Navigate between snippet placeholder
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
  })
})

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function (ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client ~= nil and client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })
-- vim.keymap.set("i", "<CR>", "pumvisible() ? '<C-y>' : '<CR>'", { expr = true })
-- vim.o.completeopt="fuzzy,menuone,noinsert"

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = true,
})

-- Rounded borders for all lspconfig float windows (hover/signature, etc.)
require('lspconfig.ui.windows').default_options.border = 'single'
vim.diagnostic.config({ float = { border = 'single' } })

-- Fallback: force a border on any LSP floating window (hover/signature/etc.)
-- Some plugin or Neovim changes may bypass lspconfig defaults; this catches all.
local _orig_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  if opts.border == nil then
    opts.border = 'single'
  end
  return _orig_open_floating_preview(contents, syntax, opts, ...)
end

-- Ensure FloatBorder is visible in transparent themes
-- You can tweak the fg to a color you prefer if needed
if vim.fn.hlID('FloatBorder') == 0 then
  vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
end

-- Make cmp borders follow FloatBorder styling
vim.api.nvim_set_hl(0, 'CmpBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'CmpDocBorder', { link = 'FloatBorder' })
