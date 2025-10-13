-- core/lazy.lua: bootstrapping lazy.nvim and import plugins 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        { import = "plugins" },
    },
    {
        defaults = { lazy = true },

        install = {
            colorscheme = { "citruszest" },
        },

        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip", "matchit", "matchparen", "tarPlugin", "zipPlugin",
                    "tohtml", "getscriptPlugin",
                },
            },
        },
    }
)

