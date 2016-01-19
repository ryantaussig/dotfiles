""""""""
" author: ryantaussig
" last update: 2016-01-19
" license: GPLv3.0 or any later version
"
" contents:
"   1. general and interface settings
"   2. colors and fonts
"   3. tabs
"   4. asciidoc-specific
"   5. python-specific
""""""""

""""""""
" 1. general and interface settings
""""""""

" turn off vi compatibility
set nocompatible

" only redraw screen when necessary
set lazyredraw

" reload files
set autoread

" set command line history
set history=1000

" set command line height
set cmdheight=2

" show last command
set showcmd

" show mode
set showmode

" enable filetype plugins
filetype plugin indent on

" set initial gui window size
if has("gui_running")
    set lines=24 columns=84
endif

" visual autocomplete
set wildmenu

" no visual or audible bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

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

" end highlighting with backslash space
nnoremap <leader><space> :nohlsearch<CR>

""""""""
" 2. colors and fonts
""""""""

" enable syntax highlighting
syntax enable

" set colorscheme for gui
if has("gui_running")
    colorscheme solarized
    set background=dark
endif

" set gui font (for Windows only)
"set guifont=DejaVu\ Sans\ Mono:h10

""""""""
" 3. tabs
""""""""

" replace tabs with spaces
set expandtab

" set tab (reading) and softtab (editing) to 4 spaces
set tabstop=4 softtabstop=4

" set indent to 4 spaces
set shiftwidth=4 

""""""""
" 4. asciidoc-specific
""""""""

" set filetype association
autocmd bufread,bufnewfile *.adoc set filetype=asciidoc

""""""""
" 5. python-specific
""""""""

" use all python highlighting
let python_highlight_all = 1

" enable auto indentation
autocmd filetype py set autoindent

" enable smart indentation
autocmd filetype py set smartindent

" set textwidth to meet pep-8 standards
autocmd filetype py textwidth=79
