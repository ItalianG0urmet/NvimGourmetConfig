-- plugins/toggleterm.lua
return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
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
