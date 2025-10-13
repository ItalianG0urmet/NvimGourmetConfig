-- plugins/toggleterm.lua
return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = { { "<A-t>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Open ToggleTerm" } },
    version = "*",
    config = function()
        require("toggleterm").setup{
            size = 20,
            open_mapping = [[<A-t>]],
            direction = "float",
            shade_terminals = true,
            start_in_insert = true,
            float_opts = {
                border = "rounded",
            },
        }
    end,
}
