let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion=1

execute pathogen#infect() 

set nocompatible
filetype plugin on
filetype plugin indent on
syntax on
set splitright
set hlsearch
set incsearch
set number
set colorcolumn=81
set cursorline
set expandtab tabstop=4 shiftwidth=4 smarttab smartindent autoindent
set virtualedit=onemore

autocmd GUIEnter * set visualbell t_vb=

if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guifont=xos4\ Terminus\ 10
  set columns=999
  set lines=999 
endif


