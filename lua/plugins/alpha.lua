-- plugin/apha.lua
return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = 'VimEnter',
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'

        local asii = [[










           █████████                                █████   █████  ███                 
          ███░░░░░███                              ░░███   ░░███  ░░░                  
         ███     ░░░   ██████  █████ ████ ████████  ░███    ░███  ████  █████████████  
        ░███          ███░░███░░███ ░███ ░░███░░███ ░███    ░███ ░░███ ░░███░░███░░███ 
        ░███    █████░███ ░███ ░███ ░███  ░███ ░░░  ░░███   ███   ░███  ░███ ░███ ░███ 
        ░░███  ░░███ ░███ ░███ ░███ ░███  ░███       ░░░█████░    ░███  ░███ ░███ ░███ 
         ░░█████████ ░░██████  ░░████████ █████        ░░███      █████ █████░███ █████
          ░░░░░░░░░   ░░░░░░    ░░░░░░░░ ░░░░░          ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ 

        ]]

        local header = {
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "Blue", 1, 1 } },
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
            { { "AlphaPurple", 0, 51 }, { "AlphaBlue", 51, 100 }},
        }

        vim.api.nvim_set_hl(0, "AlphaPurple", { fg = "#8b00ff" })
        vim.api.nvim_set_hl(0, "AlphaBlue",   { fg = "#add8ff" })
        vim.api.nvim_set_hl(0, "Red",         { fg = "#ff5555" })

        local util = require('alpha.utils')

        local var_header = vim.split(asii, '\n')
        header = util.charhl_to_bytehl(header, var_header, false)

        dashboard.section.header.opts.hl = header
        dashboard.section.header.val = var_header

        local logoFinal = {}
        for line in asii:gmatch '[^\r\n]+' do
            table.insert(logoFinal, line)
        end

        local settings_path = vim.fn.stdpath('config')
        dashboard.section.buttons.val     = {
            dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
            dashboard.button("p", "󰄉  Projects", ":Telescope projects <CR>"),
            dashboard.button('s', '  Settings', ':cd ' .. settings_path .. '<CR>:e init.lua<CR>'),
            dashboard.button('q', '󰿅  Quit', '<cmd>q<CR>'),
        }

        dashboard.section.footer.val = {
            '', 'Lain will always be god'
        }

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end,
}
