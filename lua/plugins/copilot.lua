return {
	-- copilot
	{
		"github/copilot.vim",
		config = function()
			vim.cmd('imap <silent><script><expr> <C-j> copilot#Accept("<Tab>")')
			vim.cmd("let g:copilot_no_tab_map = v:true")
			vim.cmd("let g:copilot_assume_mapped = v:true")
		end,
	},
}
