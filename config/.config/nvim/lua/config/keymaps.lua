local keymap = vim.keymap.set

-- Helper function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  keymap(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlighting
map("n", "<CR>", "<cmd>nohlsearch<CR><CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize -2<CR>")
map("n", "<C-Down>", "<cmd>resize +2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Buffer navigation
map("n", "gt", "<cmd>bnext<CR>")
map("n", "gT", "<cmd>bprevious<CR>")
map("n", "<leader>bd", "<cmd>bdelete<CR>")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
map("n", "<leader>ft", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>")
map("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<CR>")

-- LSP
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>f", vim.lsp.buf.format)

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm<CR>")
map("t", "<esc>", "<C-\\><C-n>")

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>")
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>")
map("n", "<leader>xl", "<cmd>Trouble loclist<CR>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<CR>") 