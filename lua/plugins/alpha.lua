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


        local footer_text
        if vim.fn.executable("fortune") == 1 then
            local fortune = ""
            local attempt = 0

            while attempt < 5 do
                local handle = io.popen("fortune -s")
                local output = handle:read("*a")
                handle:close()

                local lines = vim.split(output, "\n", { trimempty = true })
                if #lines > 0 and #lines <= 2 then
                    fortune = output
                    break
                end
                attempt = attempt + 1
            end

            if fortune == "" then
                local handle = io.popen("fortune -s")
                fortune = handle:read("*a")
                handle:close()
            end

            footer_text = vim.split(fortune, "\n", { trimempty = true })
        else
            footer_text = {
                "",
                "Lain will always be god",
            }
        end

        dashboard.section.footer.val = footer_text
        dashboard.section.footer.opts = {
            position = "center",
            hl = "AlphaPurple",
        }



        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end,
}
