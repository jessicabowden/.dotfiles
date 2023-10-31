-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

-- switching between tabs
map('n', 'gT', ':BufferPrevious<CR>', { silent=true })
map('n', 'gt', ':BufferNext<CR>', { silent=true })

map('n', '<Leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<Leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<Leader>ft', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>')

-- mappings for lsp
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
end

local cmp = require'cmp'

require'cmp'.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    capabilities = capabilities
    -- flags = lsp_flags,
}
