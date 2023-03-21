local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- My plugins here
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- colorscheme
	use({ "bluz71/vim-nightfly-colors" })
	use({ "bluz71/vim-moonfly-colors" })
	use({ "jacoborus/tender.vim" })

	-- nvim tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- nvim tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- lsp config
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	use({ "hrsh7th/nvim-cmp" }) -- 补全框架
	use({ "hrsh7th/cmp-nvim-lsp" }) -- lsp源
	use({ "hrsh7th/cmp-buffer" }) -- buffer源
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "onsails/lspkind.nvim" }) --fancy icon

	-- formatter
	use({ "mhartington/formatter.nvim" }) -- 代码格式化

	-- comment
	use({
		"numToStr/Comment.nvim", -- 注释
	})

	-- auto pairs
	use({ "windwp/nvim-autopairs" }) -- 自动括号补全

	-- lua lualine
	use({
		"nvim-lualine/lualine.nvim", -- 状态栏
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- 状态栏图标
	})

	-- git blame
	use({ "f-person/git-blame.nvim" })

	-- toggle terminal
	use({ "akinsho/toggleterm.nvim", tag = "*" })

	-- doxygen
	use({ "vim-scripts/DoxygenToolkit.vim" })

	-- winbar
	use({ "fgheng/winbar.nvim" })

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- nvim gps
	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- nvim navic
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	-- black
	use({ "psf/black" })

	-- copilot
	use({ "github/copilot.vim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
