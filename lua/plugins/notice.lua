-- plugins/notice.lua
return {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            lsp = {
                hover = { enabled = true },
                signature = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            messages = {
                enabled = true,
                view = "notify",
            },
            notify = {
                enabled = true,
                view = "notify",
            },
            views = {
                notify = {
                    position = { bottom = 2, right = 2 },
                    size = { width = 200, height = "auto" },
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },
        })
    end,
}

