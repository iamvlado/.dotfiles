set nocompatible   " improved mode

set history=10000  " remember more commands and search history
set shortmess=I    " don't show the intro message starting vim
set number         " show current line number as absolute number
set relativenumber " display relative numbers
set numberwidth=2  " numbers are 1 char wide
set colorcolumn=80 " show bad and extrabad line sizes
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode
set nojoinspaces   " only insert single space after a '.', '?' and '!' with a join command
set backspace=indent,eol,start " macOS stupid backspace fix
let &t_SI = "\e[6 q"           " cursor steady bar in insert mode
let &t_EI = "\e[2 q"           " cursor steady block in normal/visual modes

" turn backup off, since most stuff is in SVN, git
set nobackup
set noswapfile
set nowb

" no sounds, no flashes
set novisualbell
set noerrorbells
set t_vb=

" specify undodir (https://jovicailic.org/2017/04/vim-persistent-undo/)
set undodir=~/.vim_runtime/undodir
set undofile
set undolevels=1000  " max number of changes that can be undone
set undoreload=10000 " max number lines to save for undo on buffer reload

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

" statusline
set laststatus=2 " always show the statusline
set statusline=%<%f\ %h%m%r\⎇\ %{fugitive#statusline()}\ \▲\ %l/%L:%c

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

" (ctrl+s) => save file
nmap <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" (,s) => :%s//
nmap <leader>s :<C-u>%s//<left>
vmap <leader>s :s//<left>

" (,*) => search and replace word under cursor
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" create a new window relative to the current one
nmap <Leader><left>  :<C-u>leftabove  vnew<CR>
nmap <Leader><right> :<C-u>rightbelow vnew<CR>
nmap <Leader><up>    :<C-u>leftabove  new<CR>
nmap <Leader><down>  :<C-u>rightbelow new<CR>

" deleting text without overwriting any registers
nmap X "_d
nmap XX "_dd
vmap X "_d
vmap x "_d

" git
map <leader>gs :Gstatus<cr>
map <leader>ga :Git add --all<cr>:Gcommit<cr>

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " highlight VCS conflict

" automatically read changed files (https://unix.stackexchange.com/a/383044)
set autoread
au FocusGained,BufEnter * :checktime " also reload when we switch buffers

" automatically clean trailing whitespaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
Plug 'hail2u/vim-css3-syntax'
Plug 'jparise/vim-graphql'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'matze/vim-move'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
Plug 'SirVer/ultisnips'
Plug 'iamvlado/useful-vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()

" vim-colors-solarized {{{
colorscheme solarized

hi VertSplit ctermfg=White ctermbg=White
hi StatusLine ctermfg=LightGray ctermbg=DarkCyan
hi SignColumn ctermfg=LightGray ctermbg=LightGray
hi StatusLineNC ctermfg=LightGray ctermbg=LightGray
hi QuickFixLine ctermfg=None ctermbg=None
" }}}

" vim-jsx
let g:jsx_ext_required=0 " highlight JSX in .js files

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" ctrlp.vim
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0 " ag is fast enough
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git'
let g:ctrlp_working_path_mode = ''

" vim-move
let g:move_key_modifier = 'C'

" ack.vim
let g:ackprg = 'ag --vimgrep'
cnoreabbrev ag Ack

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" vim-tmux-navigator
let g:tmux_navigator_save_on_switch=1
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
" want to disable 'navigate to previous', have to remap all the things
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <Nop> :TmuxNavigatePrevious<cr>
