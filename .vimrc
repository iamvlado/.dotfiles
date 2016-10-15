" Make Vim more useful
  set nocompatible        " This must be first, because it changes other options as a side effect
  set shortmess+=I        " Don't show the intro message starting Vim
  set nobackup noswapfile " Don't create backup/swp files
  set visualbell t_vb=    " No beeps, no flashes
  set clipboard=unnamed   " Use os x clipboard
  set nostartofline       " Don’t reset cursor to start of line when moving around
  set noshowmode          " Don't show current mode down the bottom
  set noshowcmd           " Don't show incomplete cmds down the bottom
  set relativenumber      " Display line numbers
  set scrolloff=8         " Start scrolling when we're 8 lines away from margins
  set wrap                " Wrap long lines
  set textwidth=80        " Longer lines will be broken after white space to get this width
  set colorcolumn=80      " Bad and extrabad line sizes
  set autochdir           " Auto change working dir (could have problems with some plugins)
  set autoread            " Reload files changed outside Vim
  set mouse=a             " Mouse support in Normal mode
  set backspace=indent,eol,start " Allow backspace in insert mode

" Encoding
  set encoding=utf-8 nobomb
  set fileencodings=utf-8 " Use UTF-8 without BOM

" Ident
  set tabstop=2        " Number of spaces that a tab counts for
  set shiftwidth=2     " Number of spaces to use for each step of (auto)indent
  set smarttab
  set expandtab        " Use spaces instead of tab
  set autoindent       " Copy indent from current line when starting a new line
  set smartindent      " Only available when compiled with the +smartindent feature

" Search
  set incsearch  " Find the next match as we type the search
  set hlsearch   " Highlight searches by default
  set ignorecase " Ignore case when searching...

  " Ag — a code-searching tool similar to ack, but faster
  " https://github.com/ggreer/the_silver_searcher
    if executable('ag')
      set grepprg=ag\ --nogroup\ --nocolor
      command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    endif

" Disable <Arrow keys>
  inoremap <Up> <NOP>
  inoremap <Down> <NOP>
  inoremap <Left> <NOP>
  inoremap <Right> <NOP>
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP>

" Arrow key to navigate windows
  noremap <Down> <C-W>j
  noremap <Up> <C-W>k
  noremap <Left> <C-W>h
  noremap <Right> <C-W>l

" Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Automatically clean trailing whitespaces on save
  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun

  autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" Shortcuts
    let mapleader = ","

  " Jump to matching pairs easily, with Tab
    nnoremap <Tab> %
    vnoremap <Tab> %

  " Ctrl+s
      noremap <C-s> <esc>:w<CR>
      inoremap <C-s> <esc>:w<CR>

  " ,nm
      " Switch type of line numbers
      " http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
      " Vim 7.3 required
      let g:relativenumber = 0
      function! ToogleRelativeNumber()
        if g:relativenumber == 0
          let g:relativenumber = 1
          set norelativenumber
          set number
          echo "Show line numbers"
        elseif g:relativenumber == 1
          let g:relativenumber = 2
          set nonumber
          set relativenumber
          echo "Show relative line numbers"
        else
          let g:relativenumber = 0
          set nonumber
          set norelativenumber
          echo "Show no line numbers"
        endif
      endfunction
      nnoremap <Leader>nm :<C-u>call ToogleRelativeNumber()<cr>

  " <Esc><Esc>
      " Clear the search highlight in Normal mode
      nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

  " < >
      vnoremap < <gv
      vnoremap > >gv

  " ,s
      " Shortcut for :%s//
      nnoremap <leader>s :<C-u>%s//<left>
      vnoremap <leader>s :s//<left>

  " Create a new window relative to the current one
      nnoremap <Leader><left>  :<C-u>leftabove  vnew<CR>
      nnoremap <Leader><right> :<C-u>rightbelow vnew<CR>
      nnoremap <Leader><up>    :<C-u>leftabove  new<CR>
      nnoremap <Leader><down>  :<C-u>rightbelow new<CR>

  " Can be typed even faster than jk
    :imap jj <Esc>
    :vmap jj <Esc>

" Plugins
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'
  " Use Ag with ack.vim for search
  Bundle 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=16
    set background=light
    colorscheme solarized
  Bundle 'bling/vim-airline'
  Bundle 'vim-airline/vim-airline-themes'
    set laststatus=2                " Last window always has a status line
    let g:airline_theme='solarized'
    let g:airline_section_x = ''    " Don't display filetype
    let g:airline_section_y = ''    " Don't display encoding
    let g:airline_left_sep = ''     " Set custom left separator
    let g:airline_right_sep = ''    " Set custom right separator
  Bundle 'airblade/vim-gitgutter'
    let g:gitgutter_signs = 0
  Bundle 'mileszs/ack.vim'
    let g:ackprg = 'ag --vimgrep'
  Bundle 'kien/ctrlp.vim'
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  Bundle 'tpope/vim-vinegar'
  " set number for tree
    let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
    let g:netrw_liststyle = 3 " Default to tree listing"
    let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
  Bundle 'tpope/vim-fugitive'
  Bundle 'pangloss/vim-javascript'
  Bundle 'mxw/vim-jsx'
    let g:jsx_ext_required = 0
  Bundle 'Raimondi/delimitMate'
  "Bundle 'Yggdroot/indentLine'
    "hi IndentGuidesOdd  ctermbg=grey
    "hi IndentGuidesEven ctermbg=grey
    "let g:indentLine_char = '│'
    "let g:indentLine_color_term = 194
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'tpope/vim-surround'
  Bundle 'vim-scripts/UltiSnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    au FileType css :UltiSnipsAddFiletypes css
    au FileType javascript :UltiSnipsAddFiletypes javascript
  Bundle 'iamvlado/useful-vim-snippets'

  syntax enable
  filetype plugin indent on
