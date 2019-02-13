" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'w0rp/ale' " linting
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'

" Initialize plugin system
call plug#end()

set t_Co=256
colorscheme ChocolateLiquor

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

set directory=/tmp
set number
set ruler
set title
set backspace=indent,eol,start
set hlsearch
set clipboard=unnamed

" Highlight cursor line in active window
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

" Status line
set laststatus=2

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

" Ignore node modules
set wildignore+=**/node_modules/**

" Automatically read changed file
set autoread

" Change page before reaching last line
set scrolloff=3

" Replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Keep window position when switching buffers
au BufLeave * let b:winview = winsaveview()
au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif