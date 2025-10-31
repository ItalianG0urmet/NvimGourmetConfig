-- plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  ft = {
    "c", "cpp", "objc", "objcpp",
    "java", "rust", "python", "lua",
    "sh", "bash", "json", "yaml",
    "cmake", "kotlin"
  },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff7b7b", bg = nil })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ffb86b", bg = nil })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#9bd1ff", bg = nil })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#b7e4c7", bg = nil })

    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 2 },
      signs = false,
      underline = true,
      update_in_insert = false,
    })

    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = cmp_ok
      and cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
      or vim.lsp.protocol.make_client_capabilities()

    local function should_attach(bufnr)
      local max_bytes = 500 * 1024
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == "" then return true end
      local ok, stats = pcall(vim.loop.fs_stat, name)
      if ok and stats and stats.size > max_bytes then
        return false
      end
      return true
    end

    local user_on_attach = rawget(_G, "on_attach")
    local function on_attach(client, bufnr)
      if not should_attach(bufnr) then
        pcall(function() if client and client.stop then client.stop() end end)
        return
      end

      if client.server_capabilities and client.server_capabilities.semanticTokensProvider then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if type(user_on_attach) == "function" then
        pcall(user_on_attach, client, bufnr)
      end
    end

    local servers = {
      clangd = { filetypes = { "c", "cpp", "objc", "objcpp" } },
      rust_analyzer = { filetypes = { "rust" } },
      pyright = { filetypes = { "python" } },
      lua_ls = { filetypes = { "lua" } },
      bashls = { filetypes = { "sh", "bash" } },
      jsonls = { filetypes = { "json" } },
      yamlls = { filetypes = { "yaml" } },
      cmake = { filetypes = { "cmake" } },
      kotlin_language_server = { filetypes = { "kotlin" } },
      jdtls = { filetypes = { "java" } },
    }

    local ft_to_server = {}
    for srv, data in pairs(servers) do
      for _, ft in ipairs(data.filetypes) do
        ft_to_server[ft] = srv
      end
    end

    local configured_roots = {}

    vim.api.nvim_create_autocmd("FileType", {
      pattern = vim.tbl_keys(ft_to_server),
      callback = function()
        local ft = vim.bo.filetype
        local srv = ft_to_server[ft]
        if not srv then return end

        local ok, lspconfig = pcall(require, "lspconfig")
        if not ok or not lspconfig[srv] then
          vim.notify(("LSP '%s' non trovato"):format(srv), vim.log.levels.WARN)
          return
        end

        local root_dir = lspconfig.util.root_pattern(".git")(vim.fn.expand("%:p")) or vim.fn.getcwd()
        local key = srv .. ":" .. root_dir
        if configured_roots[key] then return end
        configured_roots[key] = true

        local opts = {
          capabilities = capabilities,
          on_attach = on_attach,
          root_dir = root_dir,
          flags = {
            debounce_text_changes = 150,
          },
        }

        if srv == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              telemetry = { enable = false },
            },
          }
        end

        if srv == "jdtls" then
          local ok_j, jdtls = pcall(require, "jdtls")
          if ok_j then jdtls.start_or_attach(opts) end
        else
          lspconfig[srv].setup(opts)
        end
      end,
    })
  end,
}

