-- Neovim 0.12 / nvim-treesitter 'main' branch configuration
local ts = require("nvim-treesitter")

ts.setup({
  -- Automatically install missing parsers when entering a buffer
  auto_install = true,
  
  -- In the new version, highlight/indent can still be configured here
  -- if the plugin provides these modules (though 0.12 has core support).
  highlight = {
    enable = true,
    disable = { "latex", "tex", "plaintex" },
  },
  indent = {
    enable = true,
  }
})

-- Core Neovim 0.12 Highlighting Fallback/Integration
-- This ensures that even if the plugin module is wonky, core TS starts.
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    
    local excluded = { "latex", "tex", "plaintex" }
    for _, e in ipairs(excluded) do
      if ft == e then return end
    end
    
    -- Start core treesitter highlighting
    pcall(vim.treesitter.start, bufnr)
  end,
})

-- Folding setup using Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false 
