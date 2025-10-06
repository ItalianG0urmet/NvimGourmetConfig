-- plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local width = math.floor(vim.o.columns * 0.20)
    local height = math.floor(vim.o.lines * 0.50)

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            row = 1,
            col = vim.o.columns - width,
            width = width,
            height = height,
            border = "rounded",
          },
        },
        side = "right",
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = { enable = true },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "🔗",
            folder = {
              default = "📁",
              open = "📂",
              empty = "📁",
              empty_open = "📂",
              arrow_closed = "▸",
              arrow_open = "▾",
              symlink = "🔗",
            },
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
           },
        },
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
    })
  end,
}
