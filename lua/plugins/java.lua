-- core/java.lua
local fn = vim.fn
local home = os.getenv("HOME")

local jabba_jdk_dir = home .. "/.jabba/jdk/"
local jdk8_dir = jabba_jdk_dir .. "1.8.0/Contents/Home"
local nvim_dir = home .. "/.config/nvim"
local rule_dir = nvim_dir .. "/rule/"
local java_settings_url = rule_dir .. "settings.prefs"
local java_format_style_rule = rule_dir .. "eclipse-java-google-style.xml"
local workspace_root = nvim_dir .. "/workspace/"

local project_name = fn.fnamemodify(fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_root .. project_name

vim.fn.mkdir(workspace_root, "p")

local function is_file_exist(path)
  local f = io.open(path, "r")
  if f then f:close(); return true end
  return false
end

local function get_lombok_javaagent()
  local lombok_dir = home .. "/.m2/repository/org/projectlombok/lombok/"
  local ok, stat = pcall(vim.loop.fs_stat, lombok_dir)
  if not ok or not stat then return "" end

  local p = io.popen('ls -1 "' .. lombok_dir .. '" 2>/dev/null | sort -r')
  if not p then return "" end
  local versions = {}
  for v in p:lines() do table.insert(versions, v) end
  p:close()
  if #versions == 0 then return "" end

  local lombok_jar_glob = string.format("%s%s/*.jar", lombok_dir, versions[1])
  local expanded = fn.expand(lombok_jar_glob)
  if expanded ~= "" and is_file_exist(expanded) then
    return string.format("--jvm-arg=-javaagent:%s", expanded)
  end
  return ""
end

local function get_cmd()
  local cmd = { "jdtls" }
  local lombok_agent = get_lombok_javaagent()
  if lombok_agent ~= "" then table.insert(cmd, lombok_agent) end
  table.insert(cmd, "-data")
  table.insert(cmd, workspace_dir)
  return cmd
end

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = function()
    local ok_jdtls, jdtls = pcall(require, "jdtls")
    if not ok_jdtls then
      vim.notify("nvim-jdtls non trovato", vim.log.levels.ERROR)
      return
    end

    local ok_lsp, lsp = pcall(require, "plugins.lsp")
    local capabilities = (ok_lsp and lsp.get_capabilities and lsp.get_capabilities())
      or vim.lsp.protocol.make_client_capabilities()

    local config = {
      cmd = get_cmd(),
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
      settings = {
        ["java.settings.url"] = java_settings_url,
        java = {
          configuration = {
            runtimes = {
              { name = "JavaSE-1.8", path = jdk8_dir },
            },
          },
          codeGeneration = {
            hashCodeEquals = { useInstanceof = true, useJava7Objects = true },
            toString = { codeStyle = "STRING_BUILDER_CHAINED" },
            useBlocks = true,
          },
          contentProvider = { preferred = "fernflower" },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          signatureHelp = { enabled = true },
          sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
          format = { settings = { url = java_format_style_rule, profile = "GoogleStyle" } },
        },
      },
      capabilities = capabilities,
      flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
        server_side_fuzzy_completion = true,
      },
      on_attach = function(client, bufnr)
        if ok_lsp and lsp.on_attach then
          lsp.on_attach(client, bufnr)
        end
      end,
    }

    jdtls.start_or_attach(config)
  end,
}

