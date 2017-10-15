set nocompatible " this must be first
set ttyfast      " indicates a fast terminal connection

" syntax
filetype off
filetype plugin indent on " enabling indentation and plugins for specific files
syntax on

set nolazyredraw      " fix vim render
set clipboard=unnamed " use macOS clipboard
set history=1000      " increase history
set timeoutlen=250    " solves: there is a pause when leaving insert mode
set autochdir         " change dir to the current buffer when opening files

" no backups
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
set undoreload=10000

" ui/ux tweaks
set shortmess=I    " don't show the intro message starting vim
set relativenumber " display relative numbers
set colorcolumn=81 " show bad and extrabad line sizes
set scrolloff=8    " start scrolling when we're 8 lines away from margins
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode

" no tabs or spaces
set tabstop=2
set shiftwidth=2
set smarttab
set et

" indentation
set autoindent
set smartindent

" search tweaks
set incsearch  " find the next match as we type the search
set hlsearch   " highlight searches by default
set ignorecase " ignore case when searching
set smartcase  " use case if any caps used

" format the statusline
set laststatus=2 " always show the statusline
set statusline=\%F%m%r%h\ %w\ \⎇\ %{fugitive#statusline()}\ \▲\ %l/%L:%c

" allow backspace in insert mode
set backspace=indent,eol,start

" disable arrow keys (╯°□°）╯︵ ┻━┻)
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>

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

" shortcuts
let mapleader = ","

" can be typed even faster than jj
imap jj <Esc>
vmap jj <Esc>

" ctrl+s
nmap <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" ctrl+q
nmap <C-q> <esc>:q<CR>
imap <C-q> <esc>:q<CR>

" <esc><esc> => сlear the search highlight in normal mode
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" < > => move blocks in visual mode
vmap < <gv
vmap > >gv

" ,s => :%s//
nmap <leader>s :<C-u>%s//<left>
vmap <leader>s :s//<left>

" netrw
nmap - :e.<CR>

" create a new window relative to the current one
nmap <Leader><left>  :<C-u>leftabove  vnew<CR>
nmap <Leader><right> :<C-u>rightbelow vnew<CR>
nmap <Leader><up>    :<C-u>leftabove  new<CR>
nmap <Leader><down>  :<C-u>rightbelow new<CR>

" ,, => no buffer side-effects mode
function! ToggleSideEffects()
  if mapcheck("dd", "n") == ""
    nmap dd "_dd
    nmap D "_D
    echo '▲ black hole register on'
  else
    unmap dd
    unmap D
    echo '▲ black hole register off'
  endif
endfunction

nmap ,, :call ToggleSideEffects()<CR>

" // => toggle js comment
function! CommentToggle()
  execute ':silent! s/\([^ ]\)/\/\/ \1/'
  execute ':silent! s/^\( *\)\/\/ \/\/ /\1/'
endfunction
map // :call CommentToggle()<CR>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_banner = 0

" plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
  let g:solarized_termtrans=1
  colorscheme solarized
  hi VertSplit ctermfg=White ctermbg=White
  hi StatusLine ctermfg=LightGray ctermbg=DarkCyan
  hi SignColumn ctermfg=LightGray ctermbg=LightGray
  hi StatusLineNC ctermfg=LightGray ctermbg=LightGray
Bundle 'pangloss/vim-javascript'
Bundle 'maxmellon/vim-jsx-pretty'
  let g:jsx_ext_required = 0
Bundle 'tpope/vim-fugitive'
  map <leader>gs :Gstatus<cr>
  map <leader>ga :Git add --all<cr>:Gcommit<cr>
Bundle 'kien/ctrlp.vim'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0 " ag is fast enough
  let g:ctrlp_working_path_mode = ''
Bundle 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
Bundle 'iamvlado/useful-vim-snippets'

" save files that requires sudo without sudo
cmap w!! w !sudo tee % >/dev/null
