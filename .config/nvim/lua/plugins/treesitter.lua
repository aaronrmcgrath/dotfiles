


file_ignore_patterns = {
    "public/vendor",
    "public/vendor/horizon",
    "node_modules",
}

-- treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            ensure_installed = { "lua", "javascript", "typescript", "c_sharp", "go", "python" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
