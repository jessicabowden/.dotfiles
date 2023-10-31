local opt = vim.opt

opt.termguicolors = true

-- add:
-- which-key (??)
-- impatient.nvim
--
-- color schemes
-- https://github.com/NvChad/nvchad.github.io/blob/src/static/img/screenshots/radium1.png
-- https://github.com/NvChad/nvchad.github.io/blob/src/static/img/screenshots/four_Themes.png

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

    -- Color schemes and appearance
  use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  use 'EdenEast/nightfox.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use 'goolord/alpha-nvim'

  use 'nvim-treesitter/nvim-treesitter'
  

  use 'lukas-reineke/indent-blankline.nvim'
  require("ibl").setup()

  use {
    'norcalli/nvim-colorizer.lua', 
    after = 'tokyonight.nvim',
    config = function()
      require('colorizer').setup()
    end
  }

  vim.opt.termguicolors = true

  -- lualine
  use {
    -- TODO set full file name relative to github dir
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- general
  use 'tpope/vim-commentary'
  use 'raimondi/delimitmate'

  use 'dstein64/vim-startuptime'

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }  -- add requires telescope

  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')

  require("telescope").load_extension('file_browser')

  -- neovim lsp
  use 'neovim/nvim-lspconfig'
  
  use { 
    'neovim/nvim-lspconfig',
    requires = {
      require'lspconfig'.pyright.setup{}
    } 
  }

  use 'neovim/nvim-lspconfig'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'mfussenegger/nvim-lint'
  require('lint').linters_by_ft = {
    markdown = {'pylint',}
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })

  -- python
  use 'Vimjas/vim-python-pep8-indent'

  -- auto dark mode
  use 'f-person/auto-dark-mode.nvim'
  local auto_dark_mode = require('auto-dark-mode')

  auto_dark_mode.setup({
          update_interval = 1000,
          set_dark_mode = function()
                  vim.api.nvim_set_option('background', 'dark')
                  vim.cmd('colorscheme sonokai')
          end,
          set_light_mode = function()
                  vim.api.nvim_set_option('background', 'light')
                  vim.cmd('colorscheme dawnfox')
          end,
  })
  auto_dark_mode.init()

end)
