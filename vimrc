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
    winpos 0 0
endif

if has("nvim") " detect neovim env
endif

let mapleader = "\<space>"
" copy and paste form system
vmap <C-S-c> "+yi
vmap <C-S-x> "+c
vmap <C-S-v> c<ESC>"+p
imap <C-S-v> <C-r><C-o>+

"---------------------
" plugin
"---------------------
call plug#begin()
Plug 'SirVer/ultisnips'
" theme
Plug 'sts10/vim-pink-moon'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'img-paste-devs/img-paste.vim'
call plug#end()

" setting for plugins
" SirVer/ultisnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
if has("win32") " detect windows env
    " keep UltiSnips allow auto-detect third-party's snippet
    let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/vimfiles/UltiSnips'] 
endif

" Plug 'lervag/vimtex'
let g:vimtex_latexmk_option='pdf -pdflatex="xelatex -synctex=1 \%S \%O" -verbose -file-line-error -interaction=nonstopmode'
let g:tex_flaver='latex'
    let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-pdf',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}
let g:vimtex_view_general_viewer = $HOME.'\AppData\Local\SumatraPDF\SumatraPDF.exe'
let g:vimtex_quickfix_mode=0  
set conceallevel=1 
let g:tex_conceal='abdmg'

" sts10/vim-pink-moon
colorscheme pink-moon

" airblade/vim-gitgutter
set updatetime=100 " update gitgutter info latency in term of ms

" img-paste.vim
autocmd FileType markdown,tex nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
function! g:LatexPasteImageFun(relpath)
    let l:ref = substitute(a:relpath, "[^a-zA-Z0-9]", "_", "g")
    execute "normal! i\\begin{figure}\r\\centering\r\\includegraphics[width=0.8\\textwidth]{" . a:relpath . "}\r\\caption{I"
    let ipos = getcurpos()
    execute "normal! a" . "mage}\r\\label{fig:" . l:ref . "}\r\\end{figure}"
    call setpos('.', ipos)
    execute "normal! ve\<C-g>"
endfunction
autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImageFun'
