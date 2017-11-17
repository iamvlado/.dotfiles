" syntax
syntax on

set clipboard=unnamed " use macOS clipboard
set autochdir         " change dir to the current buffer when opening files

" turn backup off, since most stuff is in SVN, git et.c anyway...
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

" ui/ux tweaks
set shortmess=I    " don't show the intro message starting vim
set number         " Show current line number as absolute number
set relativenumber " display relative numbers
set numberwidth=2  " Numbers are 1 char wide
set colorcolumn=81 " show bad and extrabad line sizes
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode

" no tabs or spaces
set tabstop=2               " tab = 2 spaces
set shiftwidth=2            " tab press = 2 spaces
set softtabstop=2 expandtab " tab => spaces

" indentation
set autoindent
set smartindent

" search tweaks
set incsearch  " Do highlight phrases while searching
set nohlsearch " Don't continue to highlight searched phrases
set ignorecase " Case insensitive search

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

" Change cursor based on mode
let &t_SI = "\e[6 q" " Steady bar in insert mode
let &t_EI = "\e[2 q" " Steady block in normal/visual modes

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

" < > => move blocks in visual mode
vmap < <gv
vmap > >gv

" ,s => :%s//
nmap <leader>s :<C-u>%s//<left>
vmap <leader>s :s//<left>

" automatically read changed files from disk, see https://unix.stackexchange.com/a/383044
set autoread
au FocusGained,BufEnter * :checktime " Also reload when we switch buffers

" create a new window relative to the current one
nmap <Leader><left>  :<C-u>leftabove  vnew<CR>
nmap <Leader><right> :<C-u>rightbelow vnew<CR>
nmap <Leader><up>    :<C-u>leftabove  new<CR>
nmap <Leader><down>  :<C-u>rightbelow new<CR>

" pretty up JSON data
nnoremap <Leader>j !!python -m json.tool<CR>
nnoremap <Leader>J :%!python -m json.tool<CR>
xnoremap <Leader>j :!python -m json.tool<CR>

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
nmap - :e.<CR>
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_banner = 0

" automatically read changed files from disk,
" see https://unix.stackexchange.com/a/383044
set autoread
au FocusGained,BufEnter * :checktime " Also reload when we switch buffers

" plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-fugitive'
  map <leader>gs :Gstatus<cr>
  map <leader>ga :Git add --all<cr>:Gcommit<cr>
Plug 'kien/ctrlp.vim'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0 " ag is fast enough
  let g:ctrlp_working_path_mode = ''
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
Plug 'iamvlado/useful-vim-snippets'
call plug#end()

" colorscheme
colorscheme solarized
hi VertSplit ctermfg=White ctermbg=White
hi StatusLine ctermfg=LightGray ctermbg=DarkCyan
hi SignColumn ctermfg=LightGray ctermbg=LightGray
hi StatusLineNC ctermfg=LightGray ctermbg=LightGray

" vim => es6 {improved syntax highlighting}
augroup filetype javascript syntax=javascript

" save files that requires sudo without sudo
cmap w!! w !sudo tee % >/dev/null
