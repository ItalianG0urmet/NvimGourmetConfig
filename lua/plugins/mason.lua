-- plugins/mason.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason-null-ls.nvim",
  },
  config = function()
    require("mason").setup()
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

