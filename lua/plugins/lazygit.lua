-- plugins/lazygit.lua
return {
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        keys = {
            { "<leader>h", "<cmd>LazyGit<cr>", desc = "Apri LazyGit in floating" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    }
}

