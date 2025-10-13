-- plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup {
            highlight = { enable = true },
            indent    = { enable = true },
            ensure_installed = {
                "c", "cpp", "java", "rust", "python", "lua", "bash",
                "json", "yaml", "cmake", "kotlin", "groovy", "asm",
            },
            auto_install = true,
            disable = function(lang, buf)
                return vim.api.nvim_buf_line_count(buf) > 20000
            end,
            ignore_install = {},
        }
    end,
}
