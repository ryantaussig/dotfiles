" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 09 Apr 2014
"
" Adapted by ryantaussig:
"   (2017-02-17) - added gruvbox#bg_toggle()
" -----------------------------------------------------------------------------

function! gruvbox#invert_signs_toggle()
  if g:gruvbox_invert_signs == 0
    let g:gruvbox_invert_signs=1
  else
    let g:gruvbox_invert_signs=0
  endif

  colorscheme gruvbox
endfunction

" Search Highlighting {{{

function! gruvbox#hls_show()
  set hlsearch
  call GruvboxHlsShowCursor()
endfunction

function! gruvbox#hls_hide()
  set nohlsearch
  call GruvboxHlsHideCursor()
endfunction

function! gruvbox#hls_toggle()
  if &hlsearch
    call gruvbox#hls_hide()
  else
    call gruvbox#hls_show()
  endif
endfunction

" }}}

function! gruvbox#bg_toggle()
  if &background == 'light'
    set bg=dark
  else
    set bg=light
  endif
endfunction
