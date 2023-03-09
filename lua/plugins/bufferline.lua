vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        mode = "buffers",
        --使用nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出nvim-tree 的位置
        offsets = {{
            filetve = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    }
}
