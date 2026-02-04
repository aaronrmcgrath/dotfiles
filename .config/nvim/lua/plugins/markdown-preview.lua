-- Markdown preview plugin
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    -- build = "cd app && npm install && npm run build",
    -- build = function()
    --     vim.fn["mkdp#util#install"]()
    -- end,
    keys = {
        { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
}
