"---------------------
" behaviour
"---------------------
" encode
set encoding=utf-8
set fileencoding=utf-8
" tab
set tabstop=4
set autoindent
set smartindent
set shiftwidth=4
set expandtab
set scrolloff=3

set backspace=indent,eol,start " can delete eol ect.

set hidden "no promote for buffer shift

"---------------------
" appearance 
"---------------------
" theme
" line index
set number
set relativenumber
" font
set guifont=JetBrains_Mono:h12 " for English
set guifontwide=Microsoft_YaHei_Mono:h12 " for Chinese

"---------------------
" mapping
"---------------------
if has("win32") " detect windows env
endif

if has("nvim") " detect neovim env
endif

"---------------------
" plugin
"---------------------
call plug#begin()
Plug 'SirVer/ultisnips'
" theme
Plug 'sts10/vim-pink-moon'
call plug#end()

" setting for plugins
" sts10/vim-pink-moon
colorscheme pink-moon
