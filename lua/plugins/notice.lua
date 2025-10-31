-- plugins/noice.lua
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        vim.notify = require("notify")

        require("noice").setup({
            lsp = {
                hover = { enabled = true },
                signature = { enabled = false },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            cmdline = {
                format = {
                    cmdline = { icon = ">" },
                    search_down = { icon = "/" },
                    search_up = { icon = "?" },
                    filter = { icon = "$" },
                    lua = { icon = "lua" },
                    help = { icon = "?" },
                },
            },
        })
    end,
}

