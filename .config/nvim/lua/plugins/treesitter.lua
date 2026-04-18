-- treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            auto_install = true,
            ensure_installed = { "lua", "javascript", "typescript", "c_sharp", "go", "python", "markdown", "markdown_inline" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
