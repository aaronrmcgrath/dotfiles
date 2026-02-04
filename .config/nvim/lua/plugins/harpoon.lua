


-- harpoon
return {
    {
        "ThePrimeagen/harpoon",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<C-e>", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Show harpoon marks" },
            { "<leader>a", "<CMD>lua require('harpoon.mark').add_file()<CR>", desc = "Mark file with harpoon" },
            { "<leader>hn", "<CMD>lua require('harpoon.ui').nav_next()<CR>", desc = "Go to next harpoon mark" },
            { "<leader>hp", "<CMD>lua require('harpoon.ui').nav_prev()<CR>", desc = "Go to previous harpoon mark" },
        },
        opts = {
            -- sets the mark upon calling `toggle` on the ui, instead require `:w`.
            save_on_toggle = false,

            -- saves the harpoon file upon every change. disabling it not recommended.
            save_on_change = true,

            -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
            enter_on_sendcmd = false,

            -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
            tmux_autoclose_windows = false,

            -- filetypes that you want to prevent from adding to the harpoon list menu.
            excluded_filetypes = { "harpoon" },

            -- set marks specific to each git branch inside git repository.
            mark_branch = false,

            -- enable tabline with harpoon marks.
            tabline = false,
            tabline_prefix = "   ",
            tabline_suffix = "   ",
        }
    }
}
