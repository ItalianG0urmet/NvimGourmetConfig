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
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },

            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },



            routes = {
                {
                    view = "notify",
                    filter = {
                        event = "msg_showmode",
                        find = "recording",
                    },
                },
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

