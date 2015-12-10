" Make Vim more useful
  set t_Co=256                   " Use 256 colors in vim
  set nocompatible               " This  must be first, because it changes other options as a side effect
  set backspace=indent,eol,start " Use <c-w> and <c-u>
  set hidden                     " This makes vim act like all other editors, buffers can exist in the background without being in a window
  set autoread                   " Reload files changed outside vim
  syntax on

" Encoding
  set encoding=utf-8 nobomb " Character encoding used inside Vim
  set fileencodings=utf-8   " Character encodings considered when starting to edit an existing file
  set fileformat=unix       " Always add lf in the end of file

" Interface
  set shortmess+=I   " Don't show the intro message starting Vim
  set number         " Display line numbers
  set cursorline     " Highlight the screen line of the cursor
  set title          " Set title of the window to filename [+=-] (path)
  set scrolloff=8    " Start scrolling when we're 8 lines away from margins
  set laststatus=2   " Last window always has a status line
  set colorcolumn=80 " Bad and extrabad line sizes
  set noshowmode     " Don't show current mode down the bottom

" Ident
  set list lcs=tab:▸\ ,eol:¬,trail:· " Show invisibles
  set wrap                           " Wrap long lines
  set textwidth=80                   " Longer lines will be broken after white space to get this width
  set autoindent                     " Copy indent from current line when starting a new line
  set smartindent                    " Only available when compiled with the +smartindent feature
  set shiftwidth=2                   " Number of spaces to use for each step of (auto)indent
  set expandtab                      " Use spaces instead of tab
  set tabstop=2                      " Number of spaces that a tab counts for
  set softtabstop=2                  " Number of spaces that a tab counts for while performing editing operations

" No beeps, no flashes
  set visualbell t_vb=

" Search
  set incsearch       " Find the next match as we type the search
  set hlsearch        " Highlight searches by default
  set ignorecase      " Ignore case when searching...
  set smartcase       " ...unless we type a capital

" Don't create backup/swp files
  set nobackup noswapfile nowb

" Environment
  set history=1000                                 " Store lots of history entries: :cmdline and search patterns
  command! W exec 'w !sudo tee % > /dev/null' | e! " Save file with root permissions

" Disable <Arrow keys>
  inoremap <Up> <NOP>
  inoremap <Down> <NOP>
  inoremap <Left> <NOP>
  inoremap <Right> <NOP>
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP>

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

" ,f
     " Fast grep
     " Recursive search in current directory for matches with current word
     nnoremap <Leader>f :<C-u>execute "Ack " . expand("<cword>") <Bar> cw<CR>

  " Move visual block
     vnoremap J :m '>+1<CR>gv=gv
     vnoremap K :m '<-2<CR>gv=gv

  " <Space>c/<Space>v - copy/paste
     vmap <Space>c :w !pbcopy<CR><CR>
     nmap <Space>v :r !pbpaste<CR><CR>

  " Ctrl+s
      noremap <C-s> <esc>:w<CR>
      inoremap <C-s> <esc>:w<CR>

  " ,m
      " Toggle mouse support in Normal mode
      set mouse=
      function! ToggleMouse()
        if &mouse == 'a'
          set mouse=
          echo "Mouse usage disabled"
        else
          set mouse=a
          echo "Mouse usage enabled"
        endif
      endfunction
      nnoremap <leader>m :call ToggleMouse()<CR>

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

  " Switch splits
      nnoremap <C-h> <C-W>h
      nnoremap <C-j> <C-W>j
      nnoremap <C-k> <C-W>k
      nnoremap <C-l> <C-W>l

  " Create a new window relative to the current one
      nnoremap <Leader><left>  :<C-u>leftabove  vnew<CR>
      nnoremap <Leader><right> :<C-u>rightbelow vnew<CR>
      nnoremap <Leader><up>    :<C-u>leftabove  new<CR>
      nnoremap <Leader><down>  :<C-u>rightbelow new<CR>

  " Ctrl+a and Ctrl+e in Insert Mode
      cnoremap <c-e> <end>
      inoremap     <c-e> <c-o>$
      cnoremap <c-a> <home>
      inoremap     <c-a> <c-o>^

  " Shortcuts for moving between tabs
    noremap [ gT
    noremap ] gt

  " Can be typed even faster than
    :imap jk <Esc>
    :vmap jk <Esc>

" Plugins
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'

  " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder
  Bundle 'kien/ctrlp.vim'

  " Insert mode auto-completion for quotes, parens, brackets, etc
  Bundle 'Raimondi/delimitMate'

  " :SyntasticCheck :SyntasticToggleMode
  Bundle 'scrooloose/syntastic'
    let g:syntastic_javascript_checkers = ['jslint']
    let g:syntastic_jade_checkers = ['jade_lint']
    let g:syntastic_check_on_wq = 0

  " Precision colorscheme for the vim text editor
  Bundle 'altercation/vim-colors-solarized'
    syntax enable
    let g:solarized_termcolors=16
    set background=light
    try
        colorscheme solarized
    catch /^Vim\%((\a\+)\)\=:E185/
      echo "Solarized theme not found. ,Run :BundleInstall"
    endtry
    try
      call togglebg#map("<Leader>b")
    catch /^Vim\%((\a\+)\)\=:E117/
      " :(
    endtry

  " css/less/sass/html color preview
  Bundle 'gorodinskiy/vim-coloresque'
    au BufRead *.json set filetype=json " fix missed setf for json

  " A tree explorer plugin
  Bundle 'scrooloose/nerdtree'
    nnoremap <Bs> :<C-u>NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=0
    let NERDTreeMinimalUI=1
    map <C-n> :NERDTreeToggle<CR>

  " Perform all your vim insert mode completions with Tab
  Bundle 'ervandew/supertab'

  " Vim plugin for the Perl module / CLI script 'ack'
  Bundle 'mileszs/ack.vim'

  " Shows 'Nth match out of M' at every search
  Bundle 'vim-scripts/IndexedSearch'

  " Lean & mean status/tabline for vim that's light as air
  Bundle 'bling/vim-airline'
    let g:airline_theme='solarized'
    let g:airline#extensions#tabline#fnamemod = ':t'  " Display only filename in tab
    let g:airline_section_x = ''                      " Don't display filetype
    let g:airline_section_y = ''                      " Don't display encoding
    let g:airline_left_sep = ''                       " Set custom left separator
    let g:airline_right_sep = ''                      " Set custom right separator
    let g:airline#extensions#tabline#enabled = 0      " Don't display tabs
    let g:airline#extensions#tabline#show_buffers = 0 " Don't display buffers in tab-bar with single tab

  " Provides easy code commenting
  Bundle 'scrooloose/nerdcommenter'

  " Quoting/parenthesizing made simple
  Bundle 'tpope/vim-surround'

  " Vim script for text filtering and alignment
  Bundle 'godlygeek/tabular'
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>

  " TextMate-like snippets
  Bundle 'vim-scripts/UltiSnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>" " :UltiSnipsAddFiletypes css
    au FileType css :UltiSnipsAddFiletypes css

  " My useful Vim snippets
  Bundle 'iamvlado/useful-vim-snippets'

  " Toggle the cursor shape in the terminal for Vim
  Bundle 'jszakmeister/vim-togglecursor'

  " HTML5
    " HTML5 omnicomplete and syntax
    Bundle 'othree/html5.vim'

  " CSS
    " Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
    Bundle 'hail2u/vim-css3-syntax'
    " Highlight colors in css files
    Bundle 'ap/vim-css-color'

  " JavaScript
    " Vastly improved Javascript indentation and syntax support in Vim
    Bundle 'pangloss/vim-javascript'
    " Vim syntax file to add some colorations for jQuery keywords and css selectors
    Bundle 'itspriddle/vim-jquery'
    " React JSX syntax highlighting and indenting for vim
    Bundle 'mxw/vim-jsx'
      au BufNewFile,BufReadPost *.jsx set filetype=jsx

  " JSON
    " A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing
    Bundle 'leshill/vim-json'

  " Markdown
    " Markdown Vim Mode
    Bundle 'plasticboy/vim-markdown'
      let g:vim_markdown_folding_disabled=1 " Disable Folding

  " Jade
    " Vim Jade template engine syntax highlighting and indention
    Bundle 'digitaltoad/vim-jade'
      au BufNewFile,BufReadPost *.jade set filetype=jade

  " Stylus
    " Syntax Highlighting for Stylus
    Bundle 'wavded/vim-stylus',

  filetype plugin indent on
