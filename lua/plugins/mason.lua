-- plugins/mason.lua
return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
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

