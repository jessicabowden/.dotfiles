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
    dependencies = { 
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
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
        handlers = {
          -- Default handler for all servers
          function(server_name)
            vim.lsp.config[server_name] = {
              capabilities = capabilities,
            }
            vim.lsp.enable(server_name)
          end,
          
          -- Custom handlers for specific servers
          ["ts_ls"] = function()
            vim.lsp.config.ts_ls = {
              capabilities = capabilities,
              settings = {
                typescript = {
                  preferences = {
                    importModuleSpecifier = "relative",
                  },
                },
              },
            }
            vim.lsp.enable("ts_ls")
          end,
          
          ["tailwindcss"] = function()
            vim.lsp.config.tailwindcss = {
              capabilities = capabilities,
              filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
            }
            vim.lsp.enable("tailwindcss")
          end,
          
          ["html"] = function()
            vim.lsp.config.html = {
              capabilities = capabilities,
              filetypes = { "html", "htmldjango" },
            }
            vim.lsp.enable("html")
          end,
          
          ["jsonls"] = function()
            vim.lsp.config.jsonls = {
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                },
              },
            }
            vim.lsp.enable("jsonls")
          end,
          
          ["eslint"] = function()
            vim.lsp.config.eslint = {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
            }
            vim.lsp.enable("eslint")
          end,
          
          ["lua_ls"] = function()
            vim.lsp.config.lua_ls = {
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
            }
            vim.lsp.enable("lua_ls")
          end,
        },
      })
    end,
  },

  -- LSP Configuration (nvim-lspconfig still needed as dependency)
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
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