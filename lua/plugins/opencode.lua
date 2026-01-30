return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<C-_>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to opencode", expr = true })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll opencode up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll opencode down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

			-- Ensure opencode is closed/cleaned up when exiting Neovim (prevents "job is running" on :qa/:xa)
			local aug = vim.api.nvim_create_augroup("OpencodeAutoClose", { clear = true })
			vim.api.nvim_create_autocmd("VimLeavePre", {
				group = aug,
				callback = function()
					local ok, opencode = pcall(require, "opencode")
					if not ok or type(opencode) ~= "table" then
						return
					end

					-- Helper to safely call functions on the module if they exist.
					local function try_call(name, ...)
						local fn = opencode[name]
						if type(fn) == "function" then
							pcall(fn, ...)
							return true
						end
						return false
					end

					-- Try common cleanup APIs/operators/plugins may expose.
					-- Prefer explicit session commands (used elsewhere in this config).
					pcall(opencode.command, "session.close")
					pcall(opencode.command, "session.stop")
					pcall(opencode.command, "session.quit")
					-- Try direct module functions if available.
					try_call("close")
					try_call("stop")
					try_call("shutdown")
					try_call("kill")
				end,
			})
		end,
	},
}
