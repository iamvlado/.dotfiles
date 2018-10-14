set nocompatible   " improved mode

set encoding=utf-8 " encoding UTF-8
set history=1000   " remember more commands and search history
set shortmess=I    " don't show the intro message starting vim
set cursorline     " highlight current line
set number         " show current line number as absolute number
set relativenumber " display relative numbers
set numberwidth=2  " numbers are 1 char wide
set colorcolumn=80 " show bad and extrabad line sizes
set showmatch      " % cursor will briefly jump to the matching brace
set lbr            " will wrap long lines between words
set mouse=a        " mouse support in normal mode
set nojoinspaces   " single space after a '.', '?' and '!' with a join command
set autochdir      " automatically change the current directory
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
vmap X "_d

" highlight VCS conflict
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" add the silver searcher to the runtimepath
set rtp+=/usr/local/opt/fzf

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

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
let g:netrw_banner = 0                         " hide banner
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide swp
let g:netrw_liststyle = 3                      " set tree style listing
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" automatically read changed files from disk, see https://unix.stackexchange.com/a/383044
set autoread
au FocusGained,BufEnter * :checktime " also reload when we switch buffers

" plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/AutoComplPop'
Plug 'SirVer/ultisnips'
Plug 'iamvlado/useful-vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'editorconfig/editorconfig-vim'
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

" vim-fzf
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

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nmap <C-p> :ProjectFiles<CR>

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
