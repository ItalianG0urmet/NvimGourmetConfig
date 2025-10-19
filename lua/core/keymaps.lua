-- core/keymaps.lua: mappings

vim.g.mapleader = " "

-- LSP
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>d", function() vim.lsp.buf.definition() end, vim.tbl_extend("force", opts, { desc = "LSP: goto definition" }))
vim.keymap.set("n", "<leader>i", function() vim.lsp.buf.implementation() end, vim.tbl_extend("force", opts, { desc = "LSP: implementation" }))
vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, vim.tbl_extend("force", opts, { desc = "LSP: rename" }))
vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, vim.tbl_extend("force", opts, { desc = "LSP: code action" }))

-- buffer navigation and save
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = "Buffer next" })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true, desc = "Buffer prev" })
vim.keymap.set('n', '<leader>s', ':w<CR>', { noremap = true, silent = true, desc = "Save buffer" })

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Explorer (NvimTree)" })

-- C Format
vim.keymap.set('n', '<leader>=', ':ClangFormat<CR>', { noremap = true, desc = "ClangFormat" })

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

