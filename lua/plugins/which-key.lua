-- plugins/which-key.lua
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        triggers = { { "<leader>", mode = { "n", "v", "o" } } },
        win = {
            no_overlap = true,
            width = 50,
            height = { min = 4, max = 25 },
            row = math.huge,
            padding = { 1, 2 },
            title = false,
        },
        layout = {
            width = { min = 20 },
            spacing = 3,
        },
        sort = { "mod" },
        icons = {
            mappings = false,
            separator = ": ",
            show_keys = false,
        },
        filter = function(mapping) return mapping.desc and mapping.desc ~= "" end,
    },
}

