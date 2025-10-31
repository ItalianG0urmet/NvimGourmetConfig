-- core/options.lua
local o = vim.opt

-- File Handling 
o.backup      = false
o.writebackup = false
o.swapfile    = false
o.undofile    = true
o.backupdir   = vim.fn.stdpath("data") .. "/backup//"

-- Appearance / UI 
o.termguicolors = true
o.winborder     = "rounded"
o.number        = true
o.relativenumber = true
o.signcolumn    = "yes:1"
o.ruler         = true
o.title         = true
o.showcmd       = true
o.showmatch     = true
o.wildmenu      = true
o.list          = true
o.listchars     = { tab = "▸ ", extends = "❯", precedes = "❮", nbsp = "␣" }
o.linebreak     = true
o.showbreak     = "↪"
o.fillchars     = {
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
  vert = "│",
  eob = " ",
  msgsep = "‾",
  diff = "╱",
}
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor20"

-- Splits 
o.splitbelow = true
o.splitright = true
o.splitkeep  = "screen"

-- Indentation 
o.tabstop     = 4
o.shiftwidth  = 4
o.softtabstop = 4
o.expandtab   = true
o.smartindent = true
o.autoindent  = true

-- Search 
o.ignorecase  = true
o.smartcase   = true
o.incsearch   = true
o.hlsearch    = true

-- Performance 
o.timeoutlen  = 180
o.ttimeoutlen = 10
o.updatetime  = 200
o.scrolloff   = 5

-- Editing Behavior
o.mouse      = "a"
o.clipboard  = "unnamedplus"
o.backspace  = { "indent", "eol", "start" }

-- File Navigation 
o.wildignore = {
  "*.o","*.obj","*.dll","*.exe","*.jpg","*.png","*.jpeg","*.gif","*.svg",
  "*.pyc","*.pkl","*.DS_Store","*/__pycache__/*","*/.git/*","*/build/*",
}
o.wildignorecase = true

-- Grep (ripgrep) 
if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --no-heading --smart-case"
  o.grepformat = "%f:%l:%c:%m"
end

-- Diff
o.diffopt = {
  "vertical",
  "filler",
  "closeoff",
  "context:3",
  "internal",
  "indent-heuristic",
  "algorithm:histogram",
  vim.fn.has("nvim-0.12") == 1 and "inline:char" or "linematch:60",
}

-- Misc
vim.lsp.set_log_level("off")

