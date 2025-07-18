return {
    -- Icons
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
      config = function()
        require("nvim-web-devicons").setup({
          default = true,
        })
      end,
    },
  
    -- Statusline
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { statusline = { "alpha", "dashboard" } },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
              {
                "filename",
                path = 1, -- Show relative path
              },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
        })
      end,
    },
  
    -- Startup screen
    {
      "goolord/alpha-nvim",
      event = "VimEnter",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
  
        dashboard.section.header.val = {
          "                                                     ",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
          "                                                     ",
        }
  
        dashboard.section.buttons.val = {
          dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
          dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
          dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
          dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
          dashboard.button("q", "  Quit", ":qa<CR>"),
        }
  
        alpha.setup(dashboard.opts)
  
        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyVimStarted",
          callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end,
    },
  
    -- Indent guides
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("ibl").setup({
          indent = { char = "│" },
          scope = { enabled = false },
          exclude = {
            filetypes = {
              "help",
              "alpha",
              "dashboard",
              "NvimTree",
              "Trouble",
              "lazy",
              "mason",
            },
          },
        })
      end,
    },
  
    -- Color highlighter
    {
      "norcalli/nvim-colorizer.lua",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("colorizer").setup({
          "*", -- Highlight all files
          css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css
          html = { names = false }, -- Disable parsing "names" like Blue or Gray
        })
      end,
    },
  
    -- File explorer
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
      end,
      config = function()
        require("nvim-tree").setup({
          sort_by = "case_sensitive",
          view = {
            width = 30,
            preserve_window_proportions = false,
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = false,
          },
          git = {
            enable = true,
          },
          diagnostics = {
            enable = true,
          },
          update_focused_file = {
            enable = true,
          },
          actions = {
            open_file = {
              quit_on_open = false,
              resize_window = true,
            },
          },
        })
      end,
    },
  }