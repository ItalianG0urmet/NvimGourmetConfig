-- core/keymaps.lua: mappings

vim.g.mapleader = " "

-- Coc LSP
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, opts)

-- buffer navigation and save
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>s', ':w<CR>', { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- C Format
vim.keymap.set('n', '<leader>cf', ':ClangFormat<CR>', { noremap = true })

-- Buffer close with prompt
vim.keymap.set("n", "<leader>x", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo.modified and vim.fn.bufname(bufnr) ~= "" then
    local choice = vim.fn.confirm(
      "Save buffer?",
      "&Yes\n&No\n&Back", 1
    )
    if choice == 1 then
      vim.cmd("write")
      vim.cmd("bd")
    elseif choice == 2 then
      vim.cmd("bd!")
    end
  else
    vim.cmd("bd")
  end
end, { desc = "Options to close the buffer" })

