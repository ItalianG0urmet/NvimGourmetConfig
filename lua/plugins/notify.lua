-- plugins/notify.lua
return {
  "rcarriga/nvim-notify",
  event = "VimEnter",    
  config = function()
    require("notify").setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "compact",
      background_colour = "#1e1e2e",
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
