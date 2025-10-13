-- plugins/theme.lua
return {
    "bluz71/vim-moonfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme moonfly")

        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "none", bg = "none" })

        local border_groups = {
            "LspInfoBorder",
            "CmpBorder",
            "TelescopeBorder",
            "TelescopePromptBorder",
            "TelescopeResultsBorder",
            "TelescopePreviewBorder",
            "NoiceCmdlinePopupBorder",
            "NoicePopupBorder",
            "WhichKeyBorder",
            "NotifyBorder",
        }

        for _, group in ipairs(border_groups) do
            vim.api.nvim_set_hl(0, group, { fg = "none", bg = "none" })
        end
    end,
}
