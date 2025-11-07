-- plugins/notify.lua
return {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
        require("notify").setup({
            --stages = "fade_in_slide_out",
            timeout = 5000,
            render = "wrapped-compact",
            background_colour = "#000000",
        })
        vim.notify = require("notify")
    end,
}
