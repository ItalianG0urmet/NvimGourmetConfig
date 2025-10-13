-- core/keymaps.lua: mappings

vim.g.mapleader = " "

-- LSP
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>d", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "<leader>i", function() vim.lsp.buf.implementation() end, opts)
vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, opts)

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

