""""""""
" author: ryantaussig
" license: MIT
"
" contents:
"   1. general settings
"   2. user interface settings
"   3. custom keybindings
"   4. colors and fonts
"   5. netrw tweaks
"   6. python-specific
"   7. addons
""""""""

""""""""
" 1. general settings
""""""""

" turn off vi compatibility
set nocompatible

" force 256 color mode
set t_Co=256

" reload files
set autoread

" set command line history
set history=2048

" enable filetype plugins
filetype plugin indent on

" no visual or audible bell
set noerrorbells visualbell t_vb=

""""""""
" 2. user interface settings
""""""""

" set command line height
set cmdheight=1

" set new tabs to insert 4 individual space characters but keep hard tab at 8 for compatibility with legacy documents
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" show last command
set showcmd

" visual autocomplete
set wildmenu

" show line numbers
set number

" enable [], {}, and () pair matching
set showmatch

" highlight current line
set cursorline

" ignore case while searching
set ignorecase

" search as term is entered
set incsearch

" highlight serach matches
set hlsearch

" fancy unicode list characters in gvim
set listchars=tab:→\ ,trail:·,eol:¶,extends:…,precedes:…,conceal:•,nbsp:↔

""""""""
" 3. custom keybindings
""""""""

" set leader to space
let mapleader="\<space>"

" toggle gruvbox background with space-b
nnoremap <leader>b :call gruvbox#bg_toggle()<CR>

" toggle search highlighting on an off with space-h
nnoremap <leader>h :call gruvbox#hls_toggle()<CR>

"toggle list characters
nnoremap <leader>l :set invlist<CR>

""""""""
" 4. colors and fonts
""""""""

" enable syntax highlighting
syntax enable

" set colorscheme to gruvbox
colorscheme gruvbox
set background=dark

""""""""
" 5. netrw tweaks
""""""""

" no banner
let g:netrw_banner = 0

" tree-style listing
let g:netrw_liststyle = 3

" open files in previous window not netrw window (3 for new tab)
let g:netrw_browse_split = 4

" open in vertical split
let g:netrw_altv = 1

" set split width
let g:netrw_winsize = 25

""""""""
" 6. python-specific
""""""""

" use all python highlighting
autocmd filetype py let python_highlight_all = 1

" enable auto indentation
autocmd filetype py set autoindent

" enable smart indentation
autocmd filetype py set smartindent

" set textwidth to meet pep-8 standards
autocmd filetype py textwidth=79

""""""""
" 7. addons
""""""""

" vim-airline: enable powerline fonts, use tomorrow theme for gruvbox compatibility, always show laststatus to enable airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'
set laststatus=2

