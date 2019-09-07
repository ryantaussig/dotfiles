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
"   6. language-specific
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

" enable indentation
set autoindent smartindent

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

" fancy unicode list characters
set listchars=tab:►\ ,trail:◊,eol:↵,extends:…,precedes:…,conceal:●,nbsp:␣

""""""""
" 3. custom keybindings
""""""""

" set leader to space
let mapleader="\<space>"

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
" 6. language-specific
""""""""

" 4 space family
autocmd filetype rs,php,py,md set tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" 2 space family
autocmd filetype js,ts,html,yaml set tabstop=8 softtabstop=2 shiftwidth=2 expandtab

" 4 col tab family
autocmd filetype go,xml set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" classic tab family (for legacy compatibility)
autocmd filetype sh set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

""""""""
" 7. addons
""""""""

" vim-airline: enable powerline fonts, use tomorrow theme for gruvbox compatibility, always show laststatus to enable airline, showmode not needed with airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
set laststatus=2
set noshowmode
