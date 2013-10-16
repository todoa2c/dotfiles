set nocompatible               " be iMproved
filetype off                   " required!

if has('win32') || has('win64')
	:let $VIMFILE_DIR = 'vimfiles'
	set rtp+=~/$VIMFILE_DIR/bundle/cmigemo-default-win32 " migemo
	set rtp+=~/$VIMFILE_DIR/bundle/cmigemo-default-win32/runtime " migemo
else
	:let $VIMFILE_DIR = '.vim'
	:let mapleader="\"
endif

set rtp+=$GOROOT/misc/vim      " golang
exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

if has('vim_starting')
	set rtp+=~/$VIMFILE_DIR/neobundle.vim.git

	call neobundle#rc(expand('~/' . $VIMFILE_DIR . '/bundle'))
endif

" My Bundles here:
"
" original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
" non github repos
NeoBundle 'git://git.wincent.com/command-t.git'
" ...
" ------ My Bundles --------
NeoBundle 'unite.vim'
NeoBundle 'taglist.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', {"autoload": {"insert": 1}}
NeoBundle 'Better-Javascript-Indentation'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'molokai'
NeoBundle 'Solarized'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'trinity.vim'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'vcscommand.vim'
NeoBundleLazy 'mattn/emmet-vim', {"autoload": {"filetypes": ['html']}}
NeoBundle 'fontzoom.vim'
NeoBundle 'sequence'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" NeoBundle 'Shougo/echodoc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'todoa2c/Search-unFold'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'thinca/vim-template'
NeoBundleLazy "gregsexton/gitv", {
      \ "depends": ["tpope/vim-fugitive"],
      \ "autoload": {
      \   "commands": ["Gitv"],
      \ }}
NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "pip install jedi",
      \ }}


filetype plugin indent on     " required! 
set tabstop=4
set shiftwidth=4
" no backup or swap file
set nobk
set nowritebackup
set noswapfile


"
" ----- custom key binding -----
nnoremap <Space>. :<C-u>sp $MYVIMRC<CR>
nnoremap <Space>, :<C-u>source $MYVIMRC<CR>
nnoremap <C-S-N> :cnext<CR>
nnoremap <C-S-P> :cprevious<CR>
" ------------------------------

"js
au FileType javascript set ts=4 sw=4 expandtab
au BufNewFile *.js set ft=javascript fenc=utf-8

" jslint.vim
function! s:javascript_filetype_settings()
  autocmd BufLeave     <buffer> call jslint#clear()
  autocmd BufWritePost <buffer> call jslint#check()
  autocmd CursorMoved  <buffer> call jslint#message()
endfunction
autocmd FileType javascript call s:javascript_filetype_settings()


" ----------------------------------------------------------
" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" ----------------------------------------------------------

" ----------------------------------------------------------
" vim-quickrun

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}

let g:quickrun_config['go.test'] = { 'command': 'go', 'exec': '%c test' }
augroup GoTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *_test.go set filetype=go.test
augroup END 


" ----------------------------------------------------------

" Python
au FileType python set ts=4 sw=4 expandtab omnifunc=pythoncomplete#Complete
au BufNewFile *.py set ft=python fenc=utf-8
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  " see http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#rename_command = '<Leader>R'
  let g:jedi#goto_assignments_command = '<Leader>G'
endfunction

" Unite.vim
noremap <C-_> :Unite -buffer-name=files buffer file_mru bookmark file<CR>
" openes as split
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

"" qfixhowm
let QFixHowm_MruFileMax = 30

"" Golang
filetype plugin indent on
syntax on
" save go files as utf-8 encoding
auto BufNewFile *.go set ft=go fenc=utf-8
auto BufWritePre *.go set fenc=utf-8
" auto gofmt on save
auto BufWritePre *.go Fmt
" TagBar + gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" ignore octal
set nrformats=

" todoa2c/search-unFold: keep original cursor move for e key
let g:sf_disable_expand_fold=1

" vim-template
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:r')/g
    silent! %s/<+PDIRNAME+>/\=expand('%:r')/g  " TODO: expand parent dir name
endfunction
" move to <+CURSOR+>
autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

