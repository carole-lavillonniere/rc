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
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'w0rp/ale' " linting
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'leafgarland/typescript-vim' " Typescript Syntax files
Plug 'quramy/tsuquyomi' " Typescript (completion, navigation etc)
Plug 'peitalin/vim-jsx-typescript' " TSX/JSX syntax highlighting
Plug 'tpope/vim-fireplace' " Clojure
Plug 'tpope/vim-salve' " Support for Leiningen
Plug 'guns/vim-clojure-static' " Clj indentation + syntax highlighting
Plug 'kien/rainbow_parentheses.vim'
" Gutentags is causing the insertion of hjkl characters on the screen
Plug 'ludovicchabant/vim-gutentags' " Ctags regeneration
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plug 'ap/vim-css-color'
Plug 'hashivim/vim-terraform'
Plug 'psychollama/further.vim' " Follow JavaScript imports to their source
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

set t_Co=256
colorscheme molokai

let mapleader = ","
let maplocalleader = ","

" FZF
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
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
set clipboard=unnamed

set cursorline cursorcolumn

" Status line
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'solarized dark',
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'ctags', 'fileformat', 'fileencoding', 'filetype' ] ],
      \ 'component_function': {
      \   'ctags': 'gutentags#statusline()'
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

" Autocomplete menu (like zsh)
set wildmenu
set wildmode=full

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

" Automatically read changed file
set autoread

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
  au BufNewFile,BufRead *.hcl set filetype=terraform
augroup END

" ALE lint only on save
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_linters_explicit = 1

" ALE highlight colors
highlight ALEWarning ctermbg=DarkRed
highlight ALEError ctermbg=DarkRed
highlight ALEWarningSign ctermbg=DarkRed
highlight ALEErrorSign ctermbg=DarkRed

" Nerd commenter settings
let g:NERDSpaceDelims = 1

runtime macros/matchit.vim

" Rainbow parenthesis on
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['lightgray',   'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Terraform and Packer
let g:terraform_align=1
let g:terraform_fmt_on_save=1

augroup filetype_hcl
  autocmd!
  au BufWritePre *.hcl :TerraformFmt
augroup END

