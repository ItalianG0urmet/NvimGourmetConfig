-- plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  keys = { { "c", mode = { "n", "v" }, desc = "Toggle comment" } },
  opts = {
    toggler = {
      line = "cc",
      block = "cb",
    },
    opleader = {
      line = "cc",
      block = "cb",
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
  end,
}

