-- plugins/notice.lua
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        hover = { enabled = true },
        signature = { enabled = false },
      },
      messages = {
        enabled = true,
        view = "notify",
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      views = {
        notify = {
          position = { bottom = 2, right = 2 },
          size = { width = 200, height = "auto" },
          border = { style = "rounded" },
          win_options = {
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    })
  end,
}

