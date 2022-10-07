" ------------ lua files -------------
lua require('plugins')
lua require('mappings')
lua require('startup_screen')

" ------------ GENERAL------------
set nu
set noshowmode
set mouse=a

" tabs to spaces
set expandtab
set shiftwidth=2

" pre-set to fold when opening
set foldmethod=indent
set foldlevel=1

" use system clipboard
set clipboard=unnamed

" Cursor settings
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=2\x7" " Underscore in normal mode

" Leading spaces
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" ------------ REMAPPINGS ------------
" set hlsearch
nnoremap <CR> :noh<CR><CR>

" let g:prettier#autoformat = 1

let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
