-- plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local fn = vim.fn

    local git_status_cache = {}

    local on_exit_fetch = function(result)
      if result.code == 0 then
        git_status_cache.fetch_success = true
      end
    end

    local function handle_numeric_result(cache_key)
      return function(result)
        if result.code == 0 then
          git_status_cache[cache_key] = tonumber(result.stdout:match("(%d+)")) or 0
        end
      end
    end

    local async_cmd = function(cmd_str, on_exit)
      local cmd = vim.tbl_filter(function(element)
        return element ~= ""
      end, vim.split(cmd_str, " "))

      vim.system(cmd, { text = true }, on_exit)
    end

    local async_git_status_update = function()
      async_cmd("git fetch origin", on_exit_fetch)
      if not git_status_cache.fetch_success then
        return
      end

      local behind_cmd_str = "git rev-list --count HEAD..@{upstream}"
      async_cmd(behind_cmd_str, handle_numeric_result("behind_count"))

      local ahead_cmd_str = "git rev-list --count @{upstream}..HEAD"
      async_cmd(ahead_cmd_str, handle_numeric_result("ahead_count"))
    end

    local function get_git_ahead_behind_info()
      async_git_status_update()

      local status = git_status_cache
      if not status then
        return ""
      end

      local msg = ""

      if type(status.ahead_count) == "number" and status.ahead_count > 0 then
        local ahead_str = string.format("↑[%d] ", status.ahead_count)
        msg = msg .. ahead_str
      end

      if type(status.behind_count) == "number" and status.behind_count > 0 then
        local behind_str = string.format("↓[%d] ", status.behind_count)
        msg = msg .. behind_str
      end

      return msg
    end

    local function spell()
      if vim.o.spell then
        return string.format("[SPELL]")
      end

      return ""
    end

    local function trailing_space()
      if not vim.o.modifiable then
        return ""
      end

      local line_num = nil

      for i = 1, fn.line("$") do
        local linetext = fn.getline(i)
        local idx = fn.match(linetext, [[\v\s+$]])

        if idx ~= -1 then
          line_num = i
          break
        end
      end

      local msg = ""
      if line_num ~= nil then
        msg = string.format("[%d]trailing", line_num)
      end

      return msg
    end

    local function mixed_indent()
      if not vim.o.modifiable then
        return ""
      end

      local space_pat = [[\v^ +]]
      local tab_pat = [[\v^\t+]]
      local space_indent = fn.search(space_pat, "nwc")
      local tab_indent = fn.search(tab_pat, "nwc")
      local mixed = (space_indent > 0 and tab_indent > 0)
      local mixed_same_line
      if not mixed then
        mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
        mixed = mixed_same_line > 0
      end
      if not mixed then
        return ""
      end
      if mixed_same_line ~= nil and mixed_same_line > 0 then
        return "MI:" .. mixed_same_line
      end
      local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
      local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
      if space_indent_cnt > tab_indent_cnt then
        return "MI:" .. tab_indent
      else
        return "MI:" .. space_indent
      end
    end

    local diff = function()
      local git_status = vim.b.gitsigns_status_dict
      if git_status == nil then
        return
      end

      local modify_num = git_status.changed
      local remove_num = git_status.removed
      local add_num = git_status.added

      local info = { added = add_num, modified = modify_num, removed = remove_num }
      return info
    end


    local ok, lualine = pcall(require, "lualine")
    if not ok or not lualine then
      return
    end

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = "",
        disabled_filetypes = {},
        always_divide_middle = true,
        refresh = {
          statusline = 1000,
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "filename",
            symbols = {
              readonly = "[🔒]",
            },
          },
        },
        lualine_b = {
          {
            "branch",
            fmt = function(name, _)
              return string.sub(name, 1, 20)
            end,
            color = { gui = "italic,bold" },
          },
          {
            get_git_ahead_behind_info,
            color = { fg = "#E0C479" },
          },
          {
            "diff",
            source = diff,
          },
        },
        lualine_c = {
          {
            "%S",
            color = { gui = "bold", fg = "cyan" },
          },
          {
            spell,
            color = { fg = "black", bg = "#a7c080" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
          },
          {
            trailing_space,
            color = "WarningMsg",
          },
          {
            mixed_indent,
            color = "WarningMsg",
          },
        },
        lualine_y = {
          "filetype",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "quickfix", "fugitive", "nvim-tree" },
    }
  end,
}

