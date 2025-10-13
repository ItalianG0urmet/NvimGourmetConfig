-- ~/.c/n/l/plugins/impatient.lua
return {
    'lewis6991/impatient.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('impatient')
    end
}

