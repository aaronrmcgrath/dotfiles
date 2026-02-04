


-- lsp config
return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "csharp_ls",
                    "intelephense",
                    "eslint",
                    "ts_ls",
                    "gopls",
                    "basedpyright",
                    "ltex",
                },
                automatic_installation = false
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Configure LSP servers using the new vim.lsp.config API
            vim.lsp.config.lua_ls = {
                capabilities = capabilities,
            }

            vim.lsp.config.ts_ls = {
                capabilities = capabilities,
            }

            vim.lsp.config.intelephense = {
                capabilities = capabilities,
            }

            vim.lsp.config.gopls = {
                capabilities = capabilities,
            }

            vim.lsp.config.basedpyright = {
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        }
                    }
                }
            }

            vim.lsp.config.csharp_ls = {
                capabilities = capabilities,
                root_markers = { "*.sln", "*.csproj", ".git" },
                init_options = {
                    AutomaticWorkspaceInit = true,
                    FeatureFlags = {
                        semanticHighlighting = true,
                        references = true,
                        definition = true,
                        completion = {
                            filteredTypes = { "System.String" }
                        }
                    }
                },
                enable_roslyn_analyzers = true,
                analyze_open_documents_only = false,
                enable_import_completion = true,
            }

            -- Enable all configured LSP servers
            vim.lsp.enable({ "lua_ls", "ts_ls", "intelephense", "gopls", "basedpyright", "csharp_ls" })

            -- for dotnet development, uncomment here if you need better linting with C#
            -- vim.lsp.config.sonarlint = {
            --     capabilities = capabilities,
            --     root_markers = { ".git", "*.sln", "*.csproj" },
            --     settings = {
            --         sonarlint = {
            --             languages = { "CSharp" },
            --             diagnosticLevel = "info",
            --             output = {
            --                 showAnalyzerLogs = true,
            --                 showVerboseLogs = true,
            --             },
            --             rules = {
            --                 ["*"] = { level = "on" }
            --             },
            --             disableTelemetry = true
            --         }
            --     }
            -- }
            -- vim.lsp.enable("sonarlint")

        end,
    },
}
