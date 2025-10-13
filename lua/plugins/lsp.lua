-- plugins/lsp.lua
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "LspAttach" },
    dependencies = {
        "williamboman/mason.nvim",   
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "mfussenegger/nvim-jdtls",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local lspconfig = require("lspconfig")

        local servers = {
            clangd = {},
            pyright = {},
            rust_analyzer = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                }
            },
            bashls = {},
            jsonls = {},
            yamlls = {},
            cmake = {},
            groovyls = {},
            kotlin_language_server = {},
        }

        local on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function()
                    vim.diagnostic.open_float(bufnr, {
                        focusable = false,
                        border = "rounded",
                        source = "always",
                        prefix = " ",
                        scope = "line",
                    })
                end,
            })
        end



        for name, opts in pairs(servers) do
            opts = vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, opts or {})
            local ok, _ = pcall(lspconfig[name].setup, opts)
            if not ok then
                vim.notify(("lspconfig.%s not found (will skip)"):format(name), vim.log.levels.DEBUG)
            end
        end

        local has_jdtls, jdtls = pcall(require, "jdtls")
        if has_jdtls then
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "java" },
                callback = function()
                    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
                    local config = {
                        cmd = {"jdtls"},
                        root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git"),
                        settings = {},
                        init_options = {},
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                    jdtls.start_or_attach(vim.tbl_extend("force", config, { workspace_dir = workspace_dir }))
                end,
            })
        else
            vim.notify("nvim-jdtls not installed; Java LSP (jdtls) won't auto-start. Install 'mfussenegger/nvim-jdtls' if you need Java support.", vim.log.levels.INFO)
        end

        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = true,
            update_in_insert = false,
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
    end,
}

