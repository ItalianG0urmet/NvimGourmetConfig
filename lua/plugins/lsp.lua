-- plugins/lsp.lua
return {
    "neovim/nvim-lspconfig",
    ft = {
        "c", "cpp", "objc", "objcpp",
        "java", "rust", "python", "lua",
        "sh", "bash", "json", "yaml",
        "cmake", "kotlin", "groovy"
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff7b7b", bg = nil })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ffb86b", bg = nil })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#9bd1ff", bg = nil })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#b7e4c7", bg = nil })

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 2,
            },
            signs = false,
            underline = true,
            update_in_insert = false,
        })

        vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

        local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = {}
        if cmp_ok then
            capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        else
            capabilities = vim.lsp.protocol.make_client_capabilities()
        end

        local servers = {
            clangd = { filetypes = { "c", "cpp", "objc", "objcpp" } },
            jdtls = { filetypes = { "java" } },
            rust_analyzer = { filetypes = { "rust" } },
            pyright = { filetypes = { "python" } },
            lua_ls = { filetypes = { "lua" } },
            bashls = { filetypes = { "sh", "bash" } },
            jsonls = { filetypes = { "json" } },
            yamlls = { filetypes = { "yaml" } },
            cmake = { filetypes = { "cmake" } },
            kotlin_language_server = { filetypes = { "kotlin" } },
            groovyls = { filetypes = { "groovy" } },
        }

        local ft_to_server = {}
        for srv, data in pairs(servers) do
            for _, ft in ipairs(data.filetypes) do
                ft_to_server[ft] = srv
            end
        end

        local configured = {}

        vim.api.nvim_create_autocmd("FileType", {
            pattern = vim.tbl_keys(ft_to_server),
            callback = function()
                local ft = vim.bo.filetype
                local srv = ft_to_server[ft]
                if not srv or configured[srv] then
                    return
                end
                configured[srv] = true

                local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
                if not lspconfig_ok then
                    vim.notify("nvim-lspconfig non trovato", vim.log.levels.ERROR)
                    return
                end

                if not lspconfig[srv] then
                    vim.notify(("lspconfig non ha una entry per '%s'"):format(srv), vim.log.levels.WARN)
                    return
                end

                local opts = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }

                if srv == "lua_ls" then
                    opts.settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            telemetry = { enable = false },
                        },
                    }
                end

                local ok, _ = pcall(function() lspconfig[srv].setup(opts) end)
                if not ok then
                    vim.notify(("Impossibile settare LSP '%s'"):format(srv), vim.log.levels.ERROR)
                end
            end,
        })
    end,
}

