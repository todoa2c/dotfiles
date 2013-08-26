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
NeoBundle 'neocomplcache'
NeoBundle 'Better-Javascript-Indentation'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'molokai'
NeoBundle 'Solarized'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'trinity.vim'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'vcscommand.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'fontzoom.vim'
NeoBundle 'sequence'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim2hs'
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
NeoBundle 'ervandew/supertab'
NeoBundle 'Townk/vim-autoclose'

filetype plugin indent on     " required! 
set nobk
set tabstop=4
set shiftwidth=4
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
" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
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


" supertab
let g:SuperTabDefaultCompletionType = "context"
