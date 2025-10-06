-- plugins/notify.lua
return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "compact",
      max_width = function()
        return math.floor(vim.o.columns * 0.3)
      end,
      max_height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
    })
    vim.notify = require("notify")
  end,
}
