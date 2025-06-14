return {
	-- lsp config
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{ "hrsh7th/nvim-cmp" }, -- 补全框架
	{ "hrsh7th/cmp-nvim-lsp" }, -- lsp源
	{ "hrsh7th/cmp-buffer" }, -- buffer源
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "onsails/lspkind.nvim" }, --fancy icon
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		-- Set up nvim-cmp.
		local lspkind = require("lspkind")
		local cmp = require("cmp")

		local kind_icons = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" }, -- For vsnip users.
				{ name = "path" },
				{ name = "buffer" },
			}),
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(':', {
		--	 mapping = cmp.mapping.preset.cmdline(),
		--	 sources = cmp.config.sources({
		--		 { name = 'path' }
		--	 }, {
		--		 { name = 'cmdline' }
		--	 })
		-- })

		-- define key binding which will be used lsp settings
		local set_keymap = function(bufnr)
			-- 跳转到声明
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"gd",
				"<cmd>lua vim.lsp.buf.declaration()<CR>",
				{ silent = true, noremap = true }
			)
			-- -- 跳转到定义
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true, noremap = true})
			-- -- 显示注释文档
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true, noremap = true})
			-- -- 跳转到实现
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {silent = true, noremap = true})
			-- 跳转到引用位置
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"gr",
				"<cmd>lua vim.lsp.buf.references()<CR>",
				{ silent = true, noremap = true }
			)
			-- -- 以浮窗形式显示错误
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", {silent = true, noremap = true})
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {silent = true, noremap = true})
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", {silent = true, noremap = true})
		end

		-- Set up lspconfig.
		-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("lspconfig").clangd.setup({
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				set_keymap(bufnr)
			end,
		})

		require("lspconfig").pyright.setup({
			capabilities = capabilities,
		})
	end,
}
