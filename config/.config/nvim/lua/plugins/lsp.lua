return {
  -- Mason - LSP installer
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "tailwindcss",
          "html",
          "cssls",
          "jsonls",
          "eslint",
          "pyright",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Ensure mason-lspconfig is loaded
      local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
      if not mason_lspconfig_ok then
        vim.notify("mason-lspconfig not found", vim.log.levels.ERROR)
        return
      end
      
      -- Setup LSP servers manually (setup_handlers not available in this version)
      local servers = {
        ts_ls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
          },
        },
        tailwindcss = {
          filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        },
        html = {
          filetypes = { "html", "htmldjango" },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        eslint = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        cssls = {},
        pyright = {},
      }

      -- Setup each server
      for server_name, server_config in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_config)
        
        lspconfig[server_name].setup(opts)
      end
    end,
  },

  -- TypeScript utilities
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lspconfig", "nvim-lua/plenary.nvim" },
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = {},
          tsserver_path = nil,
          tsserver_plugins = {},
          tsserver_max_memory = "auto",
          tsserver_format_options = {},
          tsserver_file_preferences = {},
          tsserver_locale = "en",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          code_lens = "off",
          disable_member_code_lens = true,
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },

  -- JSON schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          python = { "black" },
          lua = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}