-- plugins/mason.lua
return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason_ok, mason = pcall(require, "mason")
        if not mason_ok then
            vim.notify("mason.nvim not found", vim.log.levels.ERROR)
            return
        end

        mason.setup()

        local mlc_ok, mlc = pcall(require, "mason-lspconfig")
        if not mlc_ok then
            vim.notify("mason-lspconfig not found", vim.log.levels.WARN)
            return
        end

        mlc.setup({
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
            },
            automatic_installation = false,
        })
    end,
}

