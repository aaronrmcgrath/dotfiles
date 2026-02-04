


-- oil -netrw - file tree management
return {
    -- mini icons
    {
        "nvim-tree/nvim-web-devicons",
    },
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = {
            {
                "echasnovski/mini.icons",
                "nvim-tree/nvim-web-devicons",
                opts = {},
            }
        },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
        require("oil").setup({
            default_file_explorer = false,
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    },
}
