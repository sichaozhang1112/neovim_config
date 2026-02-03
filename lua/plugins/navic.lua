return {
	-- nvim navic
    {
        "SmiteshP/nvim-navic",
        enabled = true,
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            -- minimal setup; navic will be attached per-LSP in lsp on_attach
            local ok, navic = pcall(require, "nvim-navic")
            if ok and navic.setup then
                navic.setup({})
            end
        end,
    },
}
