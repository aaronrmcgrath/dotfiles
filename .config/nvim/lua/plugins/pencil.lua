-- Prose writing plugins
return {
    -- Writing mode with soft wrapping
    {
        "preservim/vim-pencil",
        ft = { "markdown", "text", "tex" },
        config = function()
            vim.g['pencil#wrapModeDefault'] = 'soft'
            vim.g['pencil#autoformat'] = 1

            -- Auto-enable for markdown and text files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "markdown", "text", "tex" },
                callback = function()
                    vim.cmd("PencilSoft")
                end
            })
        end
    },

    -- Better quote handling
    {
        "preservim/vim-textobj-quote",
        dependencies = { "kana/vim-textobj-user" },
        ft = { "markdown", "text", "tex" },
    },

    -- Sentence text object
    {
        "preservim/vim-textobj-sentence",
        dependencies = { "kana/vim-textobj-user" },
        ft = { "markdown", "text", "tex" },
    },
}
