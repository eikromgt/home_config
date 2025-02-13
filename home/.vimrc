set nocompatible
set encoding=utf-8
set updatetime=1000
set backspace=indent,eol,start
set timeoutlen=1000 ttimeoutlen=100
""""""""""""""set formatoptions-=cro

set nobackup
set nowritebackup

set number relativenumber
set signcolumn=number
set expandtab tabstop=4 shiftwidth=4
set nowrap

set termguicolors
set cursorline
set t_ut=

let &t_SI="\e[5 q"
let &t_SR="\e[3 q"
let &t_EI="\e[1 q"

nnoremap <Space> <Nop>
let mapleader="\<Space>"

set <A-v>=v
nnoremap <M-v> <C-v>
nnoremap <C-v> <Nop>

set <A-W>=W
nnoremap <A-W> <C-w>c
nnoremap <C-w>c <Nop>

"inoremap <C-H> <C-w>

cabbrev help vertical help

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'jiangmiao/auto-pairs'
    Plug 'luochen1990/rainbow'
    Plug 'easymotion/vim-easymotion'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"===============================================================================
" gruvbox
"===============================================================================
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_transparent_bg=1
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
colorscheme gruvbox
highlight Normal    guibg=NONE  ctermbg=NONE
highlight VertSplit guibg=NONE  ctermbg=NONE

"===============================================================================
" rainbow
"===============================================================================
let g:rainbow_active=1
