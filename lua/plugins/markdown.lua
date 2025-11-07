-- plugins/markdown.lua
return {
    'MeanderingProgrammer/render-markdown.nvim',
    name = 'render-markdown',
    ft = { "markdown" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {},
}

