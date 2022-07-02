return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- general
  use 'tpope/vim-commentary'
  use 'raimondi/delimitmate'
  use 'Yggdroot/indentLine'

  use 'dstein64/vim-startuptime'

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }  -- add requires telescope

  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'

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

  -- coc
  use { 'neoclide/coc.nvim', branch='release' }

  -- typescript
  use { 'prettier/vim-prettier', run = 'yarn install' }

  -- python
  use 'Vimjas/vim-python-pep8-indent'

  -- Color schemes and appearance
  use 'folke/tokyonight.nvim'
  use 'itchyny/vim-gitbranch'
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- auto dark mode
  use 'f-person/auto-dark-mode.nvim'
  local auto_dark_mode = require('auto-dark-mode')

  auto_dark_mode.setup({
          update_interval = 1000,
          set_dark_mode = function()
                  vim.api.nvim_set_option('background', 'dark')
                  vim.cmd('colorscheme tokyonight')
          end,
          set_light_mode = function()
                  vim.api.nvim_set_option('background', 'light')
                  vim.cmd('colorscheme tokyonight')
          end,
  })
  auto_dark_mode.init()

  -- lualine
  require('lualine').setup()  -- TODO set up configuration
  -- full file name relative to github dir

end)
