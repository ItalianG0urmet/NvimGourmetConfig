-- plugins/lsp.lua
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
            virtual_text = { prefix = "●", spacing = 2 },
            signs = false,
            underline = true,
            update_in_insert = false,
        })

        vim.lsp.handlers["$/progress"] = function(_, _, _, _) end
        vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    end,
}

