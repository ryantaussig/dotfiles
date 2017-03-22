""""""""
" author: ryantaussig
" last update: 2017-03-17
" license: MIT
"
" contents:
"   1. general settings
"   2. user interface settings
"   3. custom keybindings
"   4. colors and fonts
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
    set lines=999 columns=84 " 80 col., max lines
endif

" no visual or audible bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

""""""""
" 2. user interface settings
""""""""

" set command line height
set cmdheight=2

" set indent to 4 spaces and hardtab to 8
set tabstop=8
set shiftwidth=4

" use tab key for indentation and expand at tabstops
set smarttab
set expandtab

" show last command
set showcmd

" show mode
set showmode

" visual autocomplete
set wildmenu

" show line numbers in gui
if has('gui_running')
    set number
endif

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
if has('gui_running')
    set listchars=tab:»\ ,trail:·,eol:¶,extends:…,precedes:…,conceal:×,nbsp:·
else
    set listchars=tab:>\ ,trail:.,eol:$,extends:\#,precedes:\#,conceal:X,nbsp:~
endif

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

" set gui font
if has('gui_win32')
    set guifont=DejaVu\ Sans\ Mono:h12
else
    set guifont=DejaVu\ Sans\ Mono\ 12
endif

""""""""
" 5. asciidoc-specific
""""""""

" set filetype association
autocmd bufread,bufnewfile *.adoc set filetype=asciidoc

" enable auto indentation
autocmd filetype asciidoc set autoindent

" enable spell check
autocmd filetype asciidoc set spell

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
