-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

-- renaming with coc
map("n", "<Leader>rn", "<Plug>(coc-rename)")

-- switching between tabs
map('n', 'gT', ':BufferPrevious<CR>', { silent=true })
map('n', 'gt', ':BufferNext<CR>', { silent=true })

-- go to definition
map('n', 'gd', '<Plug>(coc-definition)', { silent=true })

map('n', '<Leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>')
