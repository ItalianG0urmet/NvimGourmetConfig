-- lua/plugins/indent-blankline.lua
return {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts  = {
        indent = {
            char      = "│",
            tab_char  = "│",
            highlight = "IblIndent",
        },
        scope = {
            enabled    = false,
            show_start = false,
            highlight  = "IblScope",
        },
        exclude = {
            filetypes = { "dashboard", "NvimTree", "packer", "help" },
            buftypes  = { "terminal" },
        },
    },
}
