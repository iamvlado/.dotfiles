set nocompatible      " improved mode
syntax on             " syntax
set clipboard=unnamed " use macOS clipboard
set autochdir         " change dir to the current buffer when opening files

" turn backup off, since most stuff is in SVN, git
set nobackup
set noswapfile
set nowb

" no sounds, no flashes
set novisualbell
set t_vb=
set tm=500
set noerrorbells

" specify undodir (https://jovicailic.org/2017/04/vim-persistent-undo/)
set undodir=~/.vim_runtime/undodir
set undofile
set undoreload=5000

" ui/ux
set shortmess=I    " don't show the intro message starting vim
set number         " show current line number as absolute number
set relativenumber " display relative numbers
set numberwidth=2  " numbers are 1 char wide
set colorcolumn=81 " show bad and extrabad line sizes
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode
set backspace=indent,eol,start " allow backspace in insert mode
let &t_SI = "\e[6 q"           " cursor steady bar in insert mode
let &t_EI = "\e[2 q"           " cursor steady block in normal/visual modes

" indentation
set autoindent
set smartindent
set tabstop=2               " tab = 2 spaces
set shiftwidth=2            " tab press = 2 spaces
set softtabstop=2 expandtab " tab => spaces

" search
set incsearch  " do highlight phrases while searching
set nohlsearch " don't continue to highlight searched phrases
set ignorecase " case insensitive search

" format the statusline
set laststatus=2 " always show the statusline
set statusline=\%F%m%r%h\ %w\ \⎇\ %{fugitive#statusline()}\ \▲\ %l/%L:%c

" disable arrow keys (╯°□°）╯︵ ┻━┻)
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>

" shortcuts
let mapleader = ","

" can be typed even faster than jk
imap jj <Esc>
vmap jj <Esc>

" ctrl+s
nmap <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" ctrl+q
nmap <C-q> <esc>:q<CR>
imap <C-q> <esc>:q<CR>

" ,s => :%s//
nmap <leader>s :<C-u>%s//<left>
vmap <leader>s :s//<left>

" create a new window relative to the current one
nmap <Leader><left>  :<C-u>leftabove  vnew<CR>
nmap <Leader><right> :<C-u>rightbelow vnew<CR>
nmap <Leader><up>    :<C-u>leftabove  new<CR>
nmap <Leader><down>  :<C-u>rightbelow new<CR>

" ,j => pretty up JSON data
nnoremap <Leader>j !!python -m json.tool<CR>
nnoremap <Leader>J :%!python -m json.tool<CR>
xnoremap <Leader>j :!python -m json.tool<CR>

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " highlight VCS conflict

" automatically read changed files (https://unix.stackexchange.com/a/383044)
set autoread
au FocusGained,BufEnter * :checktime " also reload when we switch buffers

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" automatically clean trailing whitespaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" netrw
nmap - :e.<CR>
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
  let g:jsx_ext_required=0 " highlight JSX in .js files
Plug 'styled-components/vim-styled-components'
Plug 'hail2u/vim-css3-syntax'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-fugitive'
  map <leader>gs :Gstatus<cr>
  map <leader>ga :Git add --all<cr>:Gcommit<cr>
Plug 'kien/ctrlp.vim'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0 " ag is fast enough
  let g:ctrlp_working_path_mode = ''
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
  let g:ackprg = 'ag --vimgrep'
  cnoreabbrev ag Ack
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
Plug 'iamvlado/useful-vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()

" colorscheme
colorscheme solarized
hi VertSplit ctermfg=White ctermbg=White
hi StatusLine ctermfg=LightGray ctermbg=DarkCyan
hi SignColumn ctermfg=LightGray ctermbg=LightGray
hi StatusLineNC ctermfg=LightGray ctermbg=LightGray

" configure vim-tmux-navigator
let g:tmux_navigator_save_on_switch=1
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
" want to disable 'navigate to previous', have to remap all the things
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <Nop> :TmuxNavigatePrevious<cr>
