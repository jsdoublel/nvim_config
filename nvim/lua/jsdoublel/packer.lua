vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
		branch = 'main',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
	-- use 'Saghen/blink.cmp'
    use 'mbbill/undotree'
    -- use 'xiyaowong/transparent.nvim'
    use 'terrortylor/nvim-comment'
    -- use 'andweeb/presence.nvim'
    use "fladson/vim-kitty"
    use 'lervag/vimtex'
    use 'ixru/nvim-markdown'
	use 'fxn/vim-monochrome'
	use 'stefanvanburen/rams.vim'
	use 'aditya-azad/candle-grey'
	use 'slugbyte/lackluster.nvim'
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	use "metalelf0/black-metal-theme-neovim"
	use 'mfussenegger/nvim-lint'
	use { 'nvim-mini/mini.nvim', version = false }
	use "wnkz/monoglow.nvim"
	-- use {
	-- 	"3rd/image.nvim",
	-- 	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
	-- 	opts = {
	-- 		processor = "magick_cli",
	-- 	}
	-- }
	-- use 'rktjmp/lush.nvim'

	-- use({
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
end)

