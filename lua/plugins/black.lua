vim.api.nvim_exec(
	[[
        augroup black_on_save
        autocmd!
        autocmd BufWritePre *.py Black
        augroup end
    ]],
	true
)
