-- Grammar and spell checking LSP
return {
    "neovim/nvim-lspconfig",
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config.ltex = {
            cmd = { "ltex-ls" },
            filetypes = { "markdown", "text", "tex" },
            root_markers = { ".git" },
            capabilities = capabilities,
            settings = {
                ltex = {
                    language = "en-US",
                }
            }
        }

        vim.lsp.enable("ltex")
    end
}
