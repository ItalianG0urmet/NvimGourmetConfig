-- plugins/mason.lua
return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason_ok, mason = pcall(require, "mason")
        if not mason_ok then
            vim.notify("mason.nvim non trovato", vim.log.levels.ERROR)
            return
        end

        mason.setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "jdtls",
                "rust_analyzer",
                "pyright",
                "lua_ls",
                "bashls",
                "jsonls",
                "yamlls",
                "cmake",
                "kotlin_language_server",
                "groovyls",
            },
            automatic_installation = true,
        })
    end,
}

