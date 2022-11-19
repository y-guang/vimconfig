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
set wildignorecase "ignore case when complete filename

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
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

"---------------------
" mapping
"---------------------
if has("win32") " detect windows env
endif

if has("nvim") " detect neovim env
endif

let mapleader = "\<space>"
" copy and paste form system
vmap <C-S-c> "+yi
vmap <C-S-x> "+c
vmap <C-S-v> c<ESC>"+p
imap <C-S-v> <C-r><C-o>+
" remove annoy scan
map <C-n> <Nop>

" ---------------------
" system related
"---------------------
if has("win32") " detect windows env
    winpos 0 0 " open 
    let $HOSTFILE="C:\\Windows\\System32\\drivers\\etc\\hosts"
    let $VIMFILES=$HOME . '\vimfiles'
endif


"---------------------
" plugin
"---------------------
call plug#begin()
Plug 'sts10/vim-pink-moon' " theme
Plug 'airblade/vim-gitgutter' " git status for line
Plug 'lervag/vimtex' " tex support
Plug 'img-paste-devs/img-paste.vim' " paste image into file
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
" editor enhance
Plug 'jiangmiao/auto-pairs'
Plug 'gcmt/wildfire.vim' " allow quick select closest text object
Plug 'junegunn/vim-after-object' " text-obj after
Plug 'tpope/vim-surround'
Plug 'svermeulen/vim-subversive' " support substitute
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'Yggdroot/indentLine' " indent hint
Plug 'justinmk/vim-sneak' " quick motion
call plug#end()

" setting for plugins
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
set conceallevel=0
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

" neoclide/coc.nvim
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-json',
            \ 'coc-clangd']
set shortmess+=c " avoid print messages when complete
" allow tab to complete
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" navigate diagnostics
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>+ <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use <leader>h to show documentation in preview window.
nnoremap <silent> <leader>h :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Plug 'jiangmiao/auto-pairs'
au FileType tex let b:AutoPairs = AutoPairsDefine({'$' : '$', '$$' : '$$'}, )

" Plug 'jiangmiao/auto-pairs'
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" Plug 'junegunn/vim-after-object'
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" Plug 'tpope/vim-surround'
" Plug 'gcmt/wildfire.vim'
let g:wildfire_objects = {
    \ "*" : ["i'", 'i"', "i)", "i]", "i}", "it"],
    \ "html,xml" : ["at", "it"],
\ }

" Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
	let g:rainbow_conf = {
	\	'guifgs': ['royalblue2', 'darkorange2', 'seagreen2', 'firebrick2'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/',],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue2', 'darkorange2', 'seagreen2', 'firebrick2', 'darkorchid2'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\		'nerdtree': 0,
	\	}
	\}

" Plug 'justinmk/vim-sneak'
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#label = 1

