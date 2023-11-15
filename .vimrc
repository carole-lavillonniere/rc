filetype plugin on

" Install Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'w0rp/ale' " linting
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
" Plug 'ludovicchabant/vim-gutentags' " Ctags regeneration

" Git
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter'

" JS TS CSS GQL
Plug 'leafgarland/typescript-vim' " Typescript Syntax files
Plug 'peitalin/vim-jsx-typescript' " TSX/JSX syntax highlighting
" Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion
Plug 'antoinemadec/coc-fzf', {'branch': 'release'} " Use FZF instead of coc.nvim built-in fuzzy finder

" Clojure
Plug 'tpope/vim-fireplace' " Clojure
Plug 'tpope/vim-salve' " Support for Leiningen
Plug 'guns/vim-clojure-static' " Clj indentation + syntax highlighting

" Terraform
Plug 'hashivim/vim-terraform'

" Go
Plug 'fatih/vim-go'

" Tmux 
" FocusGained and FocusLost autocommand events are not working in terminal vim. This plugin restores them when using vim inside Tmux.
" Plug 'tmux-plugins/vim-tmux-focus-events'

" allows you to use <Tab> for insert completion
Plug 'ervandew/supertab'

" Dockerfiles syntax
Plug 'ekalinin/Dockerfile.vim'

" Initialize plugin system
call plug#end()

set t_Co=256
colorscheme molokai
" make comments a bit lighter
hi Comment ctermfg=246 guifg=#949494

let mapleader = ","
let maplocalleader = ","

" FZF
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>c :Commands<CR>
set rtp+=/usr/local/opt/fzf

" Go auto import
let g:go_fmt_options = {
      \ 'goimports': '-local github.com',
      \ }
augroup filetype_go
  autocmd!
  au BufWritePre *.go :GoImports
augroup END
let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_decls_mode = 'fzf'
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Go debugging
:nnoremap <leader>p :GoDebugBreakpoint<CR>
:nnoremap <C-v><F1> :GoDebugContinue<CR>

" JS imports
let g:js_file_import_sort_after_insert = 1
let g:js_file_import_string_quote = '"'
let g:js_file_import_use_fzf = 1

set directory=/tmp
set number
set ruler
set title
set backspace=indent,eol,start
set hlsearch
" automatically use the system clipboard for copy and paste
set clipboard=unnamedplus

set cursorline nocursorcolumn

" CoC extensions
let g:coc_global_extensions = [
      \'coc-tsserver',]

" Coc Code navigation
nmap <Leader>d <Plug>(coc-definition)
nmap <Leader>y <Plug>(coc-type-definition)
nmap <Leader>i <Plug>(coc-implementation)
nmap <Leader>r <Plug>(coc-references)

" Coc imports
nmap <Leader>a :CocCommand tsserver.executeAutofix<CR>
nmap <Leader>o :CocCommand tsserver.organizeImports<CR>

" Status line
set laststatus=2

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'ctags', 'fileformat', 'fileencoding', 'filetype' ] ],
      \ 'component_function': {
      \   'ctags': 'gutentags#statusline()',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

" Unable old regex engine
" Fix for lag with Ruby
set re=1

filetype plugin indent on
set expandtab
set tabstop=2
set shiftwidth=2
autocmd Filetype ruby set softtabstop=2
autocmd Filetype ruby set sw=2
autocmd Filetype ruby set ts=2
"set list
set listchars=tab:▸\ ,eol:¬

set foldlevel=20
set foldmethod=syntax
autocmd FileType json set foldmethod=indent
autocmd FileType golang set foldmethod=syntax

" easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Change popup menu item color
highlight Pmenu ctermfg=0 ctermbg=DarkGrey guibg=Magenta
highlight PmenuSel ctermfg=242 ctermbg=13 guibg=DarkGrey

" Autocomplete menu
set wildmenu
set wildmode=list,full

" Remap arrow keys to do nothing
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Increase command history
set history=200

" Traverse buffers list
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Search is case sensitive if at least one letter is uppercase
set ignorecase
set smartcase

set wildignore+=**/.meteor/**

" Change page before reaching last line
set scrolloff=3

" Replace word under cursor with leader+s
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Keep window position when switching buffers
au BufLeave * let b:winview = winsaveview()
au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.ts set filetype=typescript
augroup END

" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.hcl,*.tf set filetype=terraform
augroup END

" ALE lint only on save
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_linters_explicit = 1

" ALE highlight colors
highlight ALEWarning ctermbg=DarkRed
highlight ALEError ctermbg=DarkRed
highlight ALEWarningSign ctermbg=DarkRed
highlight ALEErrorSign ctermbg=DarkRed

" Nerd commenter settings
let g:NERDSpaceDelims = 1

runtime macros/matchit.vim

" Terraform and Packer
let g:terraform_align=1
let g:terraform_fmt_on_save=1

augroup filetype_hcl
  autocmd!
  au BufWritePre *.hcl :TerraformFmt
augroup END

" . works in visual mode too
xnoremap . :norm.<CR>

" Check if any buffers were changed outside of Vim. This checks and warns you
" if you would end up with two versions of a file.
au CursorHold,CursorHoldI,FocusGained,BufEnter * checktime

" Matching parenthesis highlighting 
" (background only to avoid confusion with cursor)
hi MatchParen ctermfg=208 ctermbg=bg

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Terraform Docs
nmap <leader>t :call TerraformDocs()<CR>
fun! TerraformDocs()
    if &ft =~ "terraform"
      let s:base_url = "https://registry.terraform.io/providers/hashicorp" 
      let s:tf_version = "latest"
      let s:type_mapping = {"data": "data-sources", "resource": "resources"}
      let s:split_line = split(getline("."), " ")
      let s:type = s:type_mapping[s:split_line[0]]
      let s:keyword = trim(s:split_line[1], '"')
      let s:parts = split(s:keyword, "_")
      let s:provider = s:parts[0]
      let s:name = join(s:parts[1:], "_")
      let s:url = join([s:base_url, s:provider, s:tf_version, "docs", s:type, s:name], "/")
      silent exec "!xdg-open '".s:url."'"
      silent exec "redra!"
    else
      return
    endif
endfun
