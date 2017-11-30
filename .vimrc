set nocompatible   " improved mode

set clipboard=unnamed " clipboard integration
set encoding=utf-8 " encoding UTF-8
set history=1000   " remember more commands and search history
set shortmess=I    " don't show the intro message starting vim
set number         " show current line number as absolute number
set relativenumber " display relative numbers
set numberwidth=2  " numbers are 1 char wide
set colorcolumn=80 " show bad and extrabad line sizes
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode
set nojoinspaces   " single space after a '.', '?' and '!' with a join command
setl nofen         " no fold enable
let &t_SI = "\e[6 q" " cursor steady bar in insert mode
let &t_EI = "\e[2 q" " cursor steady block in normal/visual modes

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
set smartindent
set tabstop=2               " tab = 2 spaces
set shiftwidth=2            " tab press = 2 spaces
set softtabstop=2 expandtab " tab => spaces

" search
set incsearch  " do highlight phrases while searching
set nohlsearch " don't continue to highlight searched phrases
set ignorecase " case insensitive search

" statusline
set stl=%f\ %h%m%r\ %l/%L:%c

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

" highlight VCS conflict
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" add the silver searcher to the runtimepath
set rtp+=/usr/local/opt/fzf

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
Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'jparise/vim-graphql'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'install --all' }
Plug 'junegunn/fzf.vim'
Plug 'matze/vim-move'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/AutoComplPop'
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
hi StatusLineNC ctermfg=LightGray ctermbg=LightGray
" }}}

" vim-jsx
let g:jsx_ext_required=0 " highlight JSX in .js files

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" vim-fzf
nmap <C-p> :Files<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vim-move
let g:move_key_modifier = 'C'

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
