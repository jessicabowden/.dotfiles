local opt = vim.opt

-- General
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamed"
opt.number = true
opt.relativenumber = false
opt.showmode = false
opt.signcolumn = "yes"
opt.cursorline = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = false                      -- Disable in favor of TreeSitter indent
opt.cindent = false                          -- Disable C-style indenting
opt.shiftround = true                        -- Round indent to multiple of shiftwidth
opt.backspace = { "indent", "eol", "start" } -- Allow backspace over everything

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 1
opt.foldenable = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Other
opt.updatetime = 200
opt.timeoutlen = 300
opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
