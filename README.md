
# Neovim Config

A compact Neovim configuration focused on C++ development. Modular, lazy-loaded plugins and LSP support.

## Basic dependencies (install before using)
- Neovim 0.9 or newer  
- git  
- ripgrep (`rg`)  
- fd (or `fd-find`)  
- Node.js (for some LSP/plugins)  
- make (for building native extensions like telescope-fzf-native)  
- clangd (C/C++ language server)  
- clang-format (formatter)

## Keybindings
Leader key: `<Space>`

### Normal mode
- `<Space>d` — Go to definition (LSP)  
- `<Space>i` — Go to implementation (LSP)  
- `<Space>r` — Rename symbol (LSP)  
- `<Space>q` — Code actions (LSP)  
- `<Tab>` — Next buffer (`:bnext`)  
- `<S-Tab>` — Previous buffer (`:bprev`)  
- `<Space>s` — Save buffer (`:w`)  
- `<Space>e` — Toggle file explorer (NvimTree)  
- `<Space>cf` — Run clang-format on current buffer (`:ClangFormat`)  
- `<Space>x` — Close buffer with prompt (custom function: save/close/force-close)  
- `<Space>f` — Telescope: Find files (mapped to `find_files`)  
- `<Space>g` — Telescope: Live grep  
- `<Space>gh` — Open LazyGit (`:LazyGit`)  
- `<A-t>` (Alt + t) — Toggle floating terminal (toggleterm open mapping)  

### Insert / Select mode (completion via nvim-cmp)
- `<C-Space>` — Trigger completion menu  
- `<CR>` — Confirm selected completion item  
- `<Tab>` — If completion visible: select next; else if snippet available: expand/jump; else fallback  
- `<S-Tab>` — If completion visible: select previous; else if snippet jumpable backwards: jump; else fallback  

### Dashboard (alpha-nvim) (when dashboard is visible)
- `e` — Explorer (`:NvimTreeToggle`)  
- `f` — Find file (`:Telescope find_files`)  
- `r` — Recent files (`:Telescope oldfiles`)  
- `q` — Quit (`:qa`)
