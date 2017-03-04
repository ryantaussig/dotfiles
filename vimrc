""""""""
" author: ryantaussig
" last update: 2017-02-17
" license: GPLv2.0
"
" contents:
"   1. general settings
"   2. user interface settings
"   3. custom keybindings
"   3. colors and fonts
"   4. tabs
"   5. asciidoc-specific
"   6. python-specific
""""""""

""""""""
" 1. general settings
""""""""

" turn off vi compatibility
set nocompatible

" only redraw screen when necessary
set lazyredraw

" reload files
set autoread

" set command line history
set history=2048

" enable filetype plugins
filetype plugin indent on

" set initial gui window size
if has("gui_running")
    set lines=32 columns=84
endif

" no visual or audible bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

""""""""
" 2. user interface settings
""""""""

" set command line height
set cmdheight=2

" show last command
set showcmd

" show mode
set showmode

" visual autocomplete
set wildmenu

" show line numbers
set number

" enable [], {}, and () pair matching
set showmatch

" highlight current line in gui
if has("gui_running")
    set cursorline
endif

" ignore case while searching
set ignorecase

" search as term is entered
set incsearch

" highlight serach matches
set hlsearch

" set maximum number of open tabs
set tabpagemax=16

""""""""
" 3. custom keybindings
""""""""

" set leader to space
let mapleader="\<space>"

" toggle gruvbox background with space-b
nnoremap <leader>b :call gruvbox#bg_toggle()<CR>

" toggle search highlighting on an off with space-h
nnoremap <leader>h :call gruvbox#hls_toggle()<CR>

""""""""
" 4. colors and fonts
""""""""

" enable syntax highlighting
syntax enable

" set colorscheme to gruvbox
" in addition set light or dark variant based on assumed ambient light
if has("gui_running")
    colorscheme gruvbox
    if strftime('%H') >= 6 && strftime ('%H') <= 18
        set background=light
    else
        set background=dark
    endif
else 
    colorscheme gruvbox
    set background=dark
endif

" source .vimrc after each save so variant changes automatically
autocmd bufwritepost * source ~/.vimrc

" set gui font
if has('gui_win32')
    set guifont=DejaVu\ Sans\ Mono:h12
else
    set guifont=DejaVu\ Sans\ Mono\ 12
endif

""""""""
" 5. tabs
""""""""

" replace tabs with spaces
set expandtab

" set tab (reading) and softtab (editing) to 4 spaces
set tabstop=4 softtabstop=4

" set indent to 4 spaces
set shiftwidth=4 

""""""""
" 6. asciidoc-specific
""""""""

" set filetype association
autocmd bufread,bufnewfile *.adoc set filetype=asciidoc

" enable auto indentation
autocmd filetype asciidoc set autoindent

" enable spell check
autocmd filetype asciidoc set spell

""""""""
" 7. python-specific
""""""""

" use all python highlighting
let python_highlight_all = 1

" enable auto indentation
autocmd filetype py set autoindent

" enable smart indentation
autocmd filetype py set smartindent

" set textwidth to meet pep-8 standards
autocmd filetype py textwidth=79
