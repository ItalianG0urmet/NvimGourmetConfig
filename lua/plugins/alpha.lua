-- plugins/alpha.lua: Welcome screen
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        " ",
        " ",
        " ",
        " ",
        "  /$$$$$$                                                          /$$    ",
        " /$$__  $$                                                        | $$    ",
        "| $$  \\__/  /$$$$$$  /$$   /$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$  ",
        "| $$ /$$$$ /$$__  $$| $$  | $$ /$$__  $$| $$_  $$_  $$ /$$__  $$|_  $$_/  ",
        "| $$|_  $$| $$  \\ $$| $$  | $$| $$  \\__/| $$ \\ $$ \\ $$| $$$$$$$$  | $$    ",
        "| $$  \\ $$| $$  | $$| $$  | $$| $$      | $$ | $$ | $$| $$_____/  | $$ /$$",
        "|  $$$$$$/|  $$$$$$/|  $$$$$$/| $$      | $$ | $$ | $$|  $$$$$$$  |  $$$$/",
        " \\______/  \\______/  \\______/ |__/      |__/ |__/ |__/ \\_______/   \\___/  ",
        " ",
        " ",
        " ",
    }

    dashboard.section.buttons.val = {
        dashboard.button("e", "  Explorer", ":NvimTreeToggle <CR>"),
        dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
        " ",
        " ",
        "Let's all love Lain",
    }


    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}

