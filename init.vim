
" {{{1 plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'MarcWeber/vim-addon-local-vimrc'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'nazo/pt.vim'
  Plug 'chaoren/vim-wordmotion'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'elzr/vim-json'
  Plug 'mattn/emmet-vim'
  Plug 'w0rp/ale'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  Plug 'shawncplus/phpcomplete.vim'
  Plug 'Shougo/vimproc.vim'
  Plug 'joonty/vim-sauce'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer --rust-completer' }
  Plug 'mtth/scratch.vim'
  Plug 'jsfaint/gen_tags.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'jceb/vim-orgmode'
  Plug 'majutsushi/tagbar'
  Plug 'mattn/calendar-vim'
  Plug 'vim-scripts/utl.vim'
  Plug 'vim-scripts/SyntaxRange'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-speeddating'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'chrisbra/NrrwRgn'
  Plug 'vim-scripts/dbext.vim'
  Plug 'swekaj/php-foldexpr.vim'
  Plug 'rust-lang/rust.vim'
call plug#end()

" {{{1 leader
let mapleader=","
let maplocalleader="-"

" {{{1 encoding
set encoding=UTF-8

" {{{1 mappings
" {{{2 config file
" source config file
nnoremap <LEADER>s :so ~/.config/nvim/init.vim<CR>
" edit config file
nnoremap <LEADER>e :e ~/.config/nvim/init.vim<CR>
" {{{2 help
" jump to help tag
nnoremap <LEADER>h <C-]>
" {{{2 moving by visual lines
nnoremap j gj
nnoremap k gk
" {{{2 folding
" toggle fold
nnoremap <SPACE> za
" {{{2 split movement
" move to splits with <C-Direction>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" {{{2 split resizing
" resize horizontel splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" {{{2 search
" remove highlight
nnoremap <LEADER><SPACE> :nohl<CR>
vnoremap / "vyq/"vp<CR>
vnoremap ? "vyq?"vp<CR>
" {{{2 completion
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" {{{2 yank rest of line with <S-y>
nnoremap <S-y> y$

" {{{1 custom commands
com! Q :suspend

" {{{1 read and write gzip-files
augroup gzip
  autocmd!
  autocmd BufReadPre,FileReadPre     *.z,*.gz set bin
  autocmd BufReadPost,FileReadPost   *.z,*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost   *.z,*.gz set nobin
  autocmd BufReadPost,FileReadPost   *.z,*.gz execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePost,FileWritePost *.z,*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost *.z,*.gz !gzip <afile>:r

  autocmd FileAppendPre              *.z,*.gz !gunzip <afile>
  autocmd FileAppendPre              *.z,*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost             *.z,*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost             *.z,*.gz !gzip <afile>:r
augroup END

" {{{1 tabs
au VimEnter * let t:wd = getcwd()
au TabNew * let t:wd = getcwd()
au DirChanged * let t:wd = getcwd()
au TabEnter * if exists('t:wd') | exe 'cd' t:wd | endif

" {{{1 splits
set splitbelow
set splitright

" {{{1 indent
set shiftwidth=2
set tabstop=2
set noexpandtab
set smartindent
set smarttab

" {{{1 line numbers
set number
set relativenumber
set cursorline

" {{{1 folding
set fdm=syntax
set foldlevelstart=999

" {{{1 search
set hlsearch
set incsearch

" {{{1 arbitrary settings
set scrolloff=10

" {{{1 colorscheme
colorscheme solarized
set background=dark
au VimEnter * colorscheme solarized

" {{{1 filetype
filetype plugin on
au BufRead,BufNewFile *.jsx set filetype=javascript
au BufRead,BufNewFile *.html.twig set filetype=html.twig

" {{{1 omnifunc
set completeopt=longest,menuone
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" {{{1 the platinum searcher
" The Silver Searcher
if executable('pt')
  " Use pt over grep
  set grepprg=pt\ --nogroup\ --nocolor
endif

" {{{1 pastetoggle
set pastetoggle=<F10>

" {{{1 plugin settings
" {{{2 NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <silent> <C-n> :NERDTreeToggle<CR>
" {{{3 NERDTree Git Plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" {{{2 CtrlP
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

" Ignore these directories
set wildignore+=*/out/**
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**

if executable('pt')
  " Use pt in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""'
  com! CPI let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""' | CtrlPClearCache
  com! CPA let g:ctrlp_user_command = 'pt %s -l --nocolor -g "" -U' | CtrlPClearCache
endif
" {{{2 vim-jsx
let g:jsx_ext_required = 0
" {{{2 vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" {{{2 emmet-vim
let g:user_emmet_leader_key='<C-a>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" {{{2 ale
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 1
nmap <silent> <S-j> <Plug>(ale_next_wrap)
nmap <silent> <S-k> <Plug>(ale_previous_wrap)
" {{{2 tern_for_vim
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'
" {{{2 phpcomplete.vim
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_mappings = {
			\ 'jump_to_def': ',td',
			\ 'jump_to_def_split': ',tsd'
			\ }
" {{{2 UltiSnips
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEditSplit="vertical"
" {{{2 YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Down>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<Up>',   '<C-p>']
let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
" {{{3 mappings
nnoremap <Leader>ygd :YcmCompleter GoTo<CR>
" {{{2 scratch.vim
let g:scratch_persistence_file = '.scratch.vim'
" {{{2 gen_tags
let g:gen_tags#ctags_bin = 'ctags'
" {{{2 airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
" {{{2 tmuxline
"let g:tmuxline_preset = 'airline'
" {{{2 vim-js-context-coloring
let g:js_context_colors_jsx = 1
" {{{2 vim-plug
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}1

" vim: fdm=marker foldlevel=0 tabstop=4:

