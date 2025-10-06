-- plugins/theme.lua
return {
  "zootedb0t/citruszest.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd("colorscheme citruszest")
  end,
}
