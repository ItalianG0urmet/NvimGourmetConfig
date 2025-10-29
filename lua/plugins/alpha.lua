-- plugins/alpha.lua
return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            '                                                                             I8   ',
            '                                                                             I8   ',
            '                                                                          88888888',
            '                                                                             I8   ',
            '   ,gggg,gg    ,ggggg,   gg      gg   ,gggggg,   ,ggg,,ggg,,ggg,    ,ggg,    I8   ',
            '  dP"  "Y8I   dP"  "Y8gggI8      8I   dP""""8I  ,8" "8P" "8P" "8,  i8" "8i   I8   ',
            ' i8\'    ,8I  i8\'    ,8I  I8,    ,8I  ,8\'    8I  I8   8I   8I   8I  I8, ,8I  ,I8,  ',
            ',d8,   ,d8I ,d8,   ,d8\' ,d8b,  ,d8b,,dP     Y8,,dP   8I   8I   Yb, `YbadP\' ,d88b, ',
            'P"Y8888P"888P"Y8888P"   8P\'"Y88P"`Y88P      `Y88P\'   8I   8I   `Y8888P"Y8888P""Y8 ',
            '       ,d8I\'                                                                      ',
            '     ,dP\'8I                                                                       ',
            '    ,8"  8I                                                                       ',
            '    I8   8I                                                                       ',
            '    `8, ,8I                                                                       ',
            '     `Y8P"                                                                        ',
        }


        local function get_recent_projects(max_count)
            max_count = max_count or 6
            local seen = {}
            local projects = {}

            for _, f in ipairs(vim.v.oldfiles) do
                if f and f ~= "" then
                    local dir = vim.fn.fnamemodify(f, ":h")
                    local gitdir = vim.fn.finddir(".git", dir .. ";")
                    local root
                    if gitdir and gitdir ~= "" then
                        root = vim.fn.fnamemodify(gitdir, ":h")
                    else
                        root = dir
                    end

                    root = vim.fn.fnamemodify(root, ":p")
                    if not seen[root] and root ~= "" then
                        table.insert(projects, root)
                        seen[root] = true
                        if #projects >= max_count then
                            break
                        end
                    end
                end
            end

            if #projects == 0 then
                local home = vim.fn.expand("~")
                table.insert(projects, home)
            end

            return projects
        end

        local buttons = {
            dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
            dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }

        dashboard.section.buttons.val = buttons

        local projects = get_recent_projects(4)

        local tb = {}
        local icon = ""
        for i, p in ipairs(projects) do
            local name = vim.fn.fnamemodify(p, ":t")
            if name == "" then name = p end
            local cmd = string.format(':lua vim.cmd("cd %s") vim.cmd("Telescope find_files cwd=%s")<CR>',
                vim.fn.fnameescape(p), vim.fn.fnameescape(p))
            local label = string.format("%s  %s", icon, name)
            table.insert(tb, dashboard.button(tostring(i), "" .. label, cmd))
        end

        table.insert(dashboard.section.buttons.val, { type = "text", val = " " })

        for _, b in ipairs(tb) do
            table.insert(dashboard.section.buttons.val, b)
        end

        dashboard.section.footer.val = {
            " ",
            " ",
            "Lain is god and chatgpt is satan",
        }

        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        dashboard.config.opts.noautocmd = true
        alpha.setup(dashboard.config)
    end,
}

