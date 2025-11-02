return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy", 
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        require("project_nvim").setup {
            manual_mode = false,
            detection_methods = { "pattern" },
            patterns = { ".git", "package.json", "Makefile" },
        }

        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
            pcall(telescope.load_extension, "projects")
        end

        vim.keymap.set("n", "<leader>p", function()
            if has_telescope then
                telescope.extensions.projects.projects()
            end
        end, { desc = "Telescope Projects" })
    end,
}

