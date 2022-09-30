"---------------------
" Basic Info
"---------------------
" Windows
"   In windows, the path of all config is in the file $HOME/vimfiles.
"   As no $HOME env var, it is c:/Users/User_Name/vimfiles.

"---------------------
" behaviour
"---------------------
" encode
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
" tab
set tabstop=4
set softtabstop=4
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
" Plug 'SirVer/ultisnips'
" theme
Plug 'sts10/vim-pink-moon'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" setting for plugins
" SirVer/ultisnips
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" if has("win32") " detect windows env
"     " keep UltiSnips allow auto-detect third-party's snippet
"     let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'vimfiles/UltiSnips'] 
" endif
" sts10/vim-pink-moon
colorscheme pink-moon
" airblade/vim-gitgutter
set updatetime=100 " update gitgutter info latency in term of ms
" neoclide/coc.nvim
let g:coc_global_extensions = [
    \ 'coc-marketplace',
    \ 'coc-json',
    \ 'coc-vimlsp']
" avoid print messages when complete
set shortmess+=c
" make TAB work
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" pop up coc with ctrl + o
inoremap <silent><expr> <c-o> coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
