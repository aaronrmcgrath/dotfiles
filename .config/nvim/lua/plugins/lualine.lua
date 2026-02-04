


-- stylua: ignore
local colors = {
    blue         = "#65BAE0", -- honolulu blue, lions' blue
    cyan         = "#79dac8",
    black        = "#080808",
    white        = "#c6c6c6",
    red          = "#CE1126", -- red wing's red
    orange       = "#FA4616", -- tiger's orange
    yellow       = "#FFCB05", -- u of mi gold
    violet       = "#9663C4",
    grey         = "#303030",
    darkgrey     = "#3c3836",
    lightgrey    = "#504945",
    inactivegrey = "#7c6f64",
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.grey, },
    },

    insert = {
        a = { fg = colors.black, bg = colors.red },
    },

    visual = {
        a = { fg = colors.black, bg = colors.yellow },
    },

    command = {
        a = { fg = colors.black, bg = colors.orange },
    },

    replace = {
        a = { fg = colors.black, bg = colors.red },
    },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = bubbles_theme,
                component_separators = " «•» ",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { { "mode", separator = { left = "" }, right_padding = 2} },
                lualine_b = {
                    "branch",
                    "diff",

                    -- diagnostics
                    {"diagnostics",
                        -- Table of diagnostic sources, available sources are:
                        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                        -- or a function that returns a table as such:
                        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                        sources = { 'nvim_diagnostic', 'vim_lsp' },
                        -- sources = { "nvim_diagnostic" },

                        -- Displays diagnostics for the defined severity types
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = 'DiagnosticError', -- Changes diagnostics' error color.
                            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                        },
                        symbols = { error = '✗ ', warn = '⚠ ', info = 'ℹ ', hint = '➤ ' },
                        colored = true,           -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false,   -- Show diagnostics even if there are none.
                    },

                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_c = {
                    "%=", -- [[ add you center components here in place of this comment ]]
                },
                lualine_x = {},
                lualine_y = { "encoding", "fileformat", "filetype", "progress" },
                lualine_z = {
                    { "location", separator = { right = "" }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
            tabline = {},
            extensions = {},
        })
    end,
}
