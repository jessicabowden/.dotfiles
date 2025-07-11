return {
    -- Fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      lazy = false, -- Load immediately
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        "nvim-telescope/telescope-live-grep-args.nvim", -- Enhanced live grep with args
        "nvim-telescope/telescope-ui-select.nvim",      -- Use telescope for vim.ui.select
        "nvim-telescope/telescope-file-browser.nvim",   -- File browser in telescope
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
  
        telescope.setup({
          defaults = {
            mappings = {
              i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              },
            },
            prompt_prefix = "🔍 ",
            selection_caret = "➤ ",
            path_display = { "truncate" },
          },
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
            live_grep_args = {
              auto_quoting = true,
            },
          },
        })
  
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
      end,
    },
  
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      lazy = false, -- Load immediately instead of on events
      dependencies = {
        "windwp/nvim-ts-autotag",
      },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "javascript",
            "typescript",
            "tsx", -- This handles JSX in TypeScript
            "html",
            "css",
            "json",
            "yaml",
            "markdown",
            "python",
            "lua",
            "vim",
            "bash",
            "dockerfile",
            "gitignore",
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = { 
            enable = true,
            disable = { "yaml" }, -- yaml indentation is sometimes problematic
          },
          autotag = { enable = true },
        })
      end,
    },
  
    -- Auto pairs
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({
          check_ts = true,
          ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
          },
          disable_filetype = { "TelescopePrompt", "spectre_panel" },
          fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
          },
        })
  
        -- Integration with nvim-cmp
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
  
    -- Comments
    {
      "numToStr/Comment.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("Comment").setup()
      end,
    },
  
    -- Surround
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end,
    },
  
    -- Git integration
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
          },
          current_line_blame = true,
          current_line_blame_opts = {
            delay = 300,
          },
        })
      end,
    },
  
    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup({
          size = 20,
          open_mapping = [[<c-\>]],
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = "float",
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
              border = "Normal",
              background = "Normal",
            },
          },
        })
      end,
    },
  
    -- Trouble
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("trouble").setup({})
      end,
    },
  }