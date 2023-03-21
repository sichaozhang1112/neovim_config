vim.cmd('imap <silent><script><expr> <C-i> copilot#Accept("<Tab>")')
vim.cmd("let g:copilot_no_tab_map = v:true")
vim.cmd("let g:copilot_assume_mapped = v:true")
