return {
	-- winbar
	{
		"fgheng/winbar.nvim",
        config = function()
            require("winbar").setup({
                enabled = true, -- 是否启动winbar

				show_file_path = true, -- 是否显示文件路径
				show_symbols = true, -- 是否显示函数标签

				-- 颜色配置，为空，将使用默认配色
				colors = {
					path = "", -- 路径的颜色，比如#ababab
					file_name = "", -- 文件名称的颜色，比如#acacac
					symbols = "", -- 函数颜色
				},

				-- 图标配置
				icons = {
					seperator = ">", -- 路径分割符号
					editor_state = "●",
					lock_icon = "",
				},

				-- 关闭winbar的窗口
                exclude_filetype = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"alpha",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"qf",
                },
            })
            -- Try to show navic symbols in winbar when available
            local ok, navic = pcall(require, "nvim-navic")
            if ok then
                -- attach navic when LSP attaches; lsp.lua will also attach navic per buffer
                -- but ensure navic is available in winbar
                -- winbar.nvim will query navic itself if configured; no extra wiring needed here
            end
        end,
	},
}
