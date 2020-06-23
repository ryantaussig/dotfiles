""""""""
" author: ryantaussig
" license: MIT
"
" contents:
"   1. general settings
"   2. user interface settings
"   3. custom keybindings
"   4. colors and fonts
"   5. tab-settings
"   6. addons
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

" use a single directory for Vim's temporary files
" The `//` notation prevents filename conflicts by expanding to the full path
" of the swapfile's parent with `%` substituted for `/`. Use `/var/tmp` to
" preserve swapfiles between reboots and prevent multiple copies in various
" user home directories.
set directory=/var/tmp//
set undodir=/var/tmp//
set backupdir=/var/tmp//

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

" highlight column 80 for tracking line length
set colorcolumn=80

""""""""
" 3. custom keybindings
""""""""

" set leader to space
let mapleader="\<space>"

" toggle search highlighting on an off with space-h
nnoremap <leader>h :call gruvbox#hls_toggle()<CR>

" toggle list characters
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
" 5. tab-settings
""""""""

" 4 space family
autocmd filetype rust,typescript,typescriptreact,php,python,markdown set tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" 2 space family
autocmd filetype javascript,javascriptreact,json,html,yaml,xml set tabstop=8 softtabstop=2 shiftwidth=2 expandtab

" 4 col tab family
autocmd filetype go set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" classic tab family (for legacy compatibility)
autocmd filetype sh set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

""""""""
" 6. addons
""""""""

" vim-airline: enable powerline fonts, use tomorrow theme for gruvbox compatibility, always show laststatus to enable airline, showmode not needed with airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
set laststatus=2
set noshowmode
