-- nvim-web-devicons.lua
return {
  'kyazdani42/nvim-web-devicons',
  lazy = true,
  config = function()
    require('nvim-web-devicons').setup {
      default = true;
    }
  end
}

