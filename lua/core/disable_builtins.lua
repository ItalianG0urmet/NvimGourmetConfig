-- core/disable_builtins.lua: Disable build-in
vim.g.loaded_python_provider  = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0

local disabled_plugins = {
  'gzip','zip','zipPlugin','tar','tarPlugin',
  'getscript','getscriptPlugin','vimball','vimballPlugin',
  '2html_plugin','logiPat','rrhelper','netrw','netrwPlugin',
  'netrwSettings','netrwFileHandlers'
}
for _, plugin in ipairs(disabled_plugins) do
  vim.g['loaded_' .. plugin] = 1
end

