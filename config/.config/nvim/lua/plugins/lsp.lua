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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup handlers for mason-lspconfig
      require("mason-lspconfig").setup_handlers({
        -- Default handler for all servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Custom handlers for specific servers
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            settings = {
              typescript = {
                preferences = {
                  importModuleSpecifier = "relative",
                },
              },
            },
          })
        end,

        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
          })
        end,

        ["html"] = function()
          lspconfig.html.setup({
            capabilities = capabilities,
            filetypes = { "html", "htmldjango" },
          })
        end,

        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,

        ["eslint"] = function()
          lspconfig.eslint.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end,
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
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
          })
        end,
      })
    end,
  },

  -- TypeScript utilities
  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = { "nvim-lspconfig" },
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("typescript").setup({
        disable_commands = false,
        debug = false,
        go_to_source_definition = {
          fallback = true,
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