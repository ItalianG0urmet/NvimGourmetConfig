-- plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = { "<leader>f", "<leader>g" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
  },
  config = function()
    local has_fd = (vim.fn.executable("fd") == 1)
    local has_rg = (vim.fn.executable("rg") == 1)

    local find_cmd = has_fd
      and { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
      or { "find", ".", "-type", "f" }

    local telescope = require("telescope")
    telescope.setup{
      defaults = {
        vimgrep_arguments = has_rg and {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        } or {},

        file_ignore_patterns = {
          "%.git/",
          "%.idea/",
          "%.vim/",
          "%.class$",
          "node_modules/",
          "dist/",
          "target/",
          "build/",
        },

        path_display = { "tail" },

        prompt_prefix = "🔎 ",

        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },

        file_sorter = require("telescope.sorters").get_fzy_sorter(),
      },

      pickers = {
        find_files = {
          find_command = find_cmd,
          previewer = false,
        },

        live_grep = {
          previewer = false,
        },

        buffers = {
          previewer = false,
          sort_lastused = true,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      },
    }

    pcall(telescope.load_extension, "fzf")

    local tele = require("telescope.builtin")
    vim.keymap.set("n", "<leader>f", function()
      tele.find_files({ previewer = false })
    end, { desc = "Telescope Find Files (fast)" })

    vim.keymap.set("n", "<leader>g", function()
      tele.live_grep({ previewer = false })
    end, { desc = "Telescope Live Grep (fast)" })
  end,
}

