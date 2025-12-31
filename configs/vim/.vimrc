let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'itchyny/lightline.vim'
Plug 'yggdroot/leaderf', { 'do': ':LeaderfInstallCExtension' }
call plug#end()
packadd! matchit
packadd! editorconfig
packadd comment
packadd nohlsearch
packadd hlyank
source $VIMRUNTIME/defaults.vim

"Statusline
set laststatus=2
let g:lightline = { 'colorscheme': 'nightfly' }
let mapleader = " "

"fzf popup
let g:Lf_WindowPosition = 'popup'
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_ShortcutF = "<leader>ff"
"End Statusline

set incsearch
set undofile
set hlsearch
set wildmenu
set ttimeout
set ttimeoutlen=100 "Set to higher number if remote connection is slow, affects escape reaction time
set display=truncate
set nrformats-=octal
set nolangremap
set magic
" Research set re=0 "Regexpengine
set scrolloff=10
set wrap
set numberwidth=4
set number
set relativenumber
set termguicolors
set splitright
set splitbelow
set showtabline=2
set tabclose=uselast
set tabpagemax=10
set term=xterm-kitty
colorscheme nightfly

syntax on
filetype plugin on
filetype plugin indent on

augroup RestoreCursor
	autocmd!
	autocmd BufReadPost *
	\ let line = line("'\"")
	\ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
	\      && index(['xxd', 'gitrebase'], &filetype) == -1
	\      && !&diff
	\ |   execute "normal! g`\""
	\ | endif
augroup END

"Copy-paste
nmap p "+p
nmap P "+P
vmap p "+p
vmap P "+P
vmap y "+y
nmap y "+y

nmap <leader>q <cmd>q<CR>
nmap <leader>Q <cmd>qall<CR>
nmap <leader>ff <cmd>Leaderf rg --hidden --no-auto-preview --fuzzy<CR>
nmap <leader><leader> <cmd>Leaderf buffer<CR>
nmap <leader>fq <cmd>Leaderf quickfix<CR>
nmap <leader>fh <cmd>Leaderf help<CR>
