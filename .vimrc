" Make Vim more useful
  set nocompatible               " This  must be first, because it changes other options as a side effect
  set shortmess+=I               " Don't show the intro message starting Vim
  set nobackup noswapfile        " Don't create backup/swp files
  set visualbell t_vb=           " No beeps, no flashes
  set backspace=indent,eol,start " Use <c-w> and <c-u>
  set clipboard=unnamed          " use os x clipboard
  set relativenumber             " Display line numbers
  set scrolloff=8                " Start scrolling when we're 8 lines away from margins
  set laststatus=2               " Last window always has a status line
  set colorcolumn=80             " Bad and extrabad line sizes
  set noshowmode                 " Don't show current mode down the bottom
  set wrap                       " Wrap long lines
  set textwidth=80               " Longer lines will be broken after white space to get this width


" Encoding
  set encoding=utf-8 nobomb " Character encoding used inside Vim
  set fileencodings=utf-8   " Character encodings considered when starting to edit an existing file
  set fileformat=unix       " Always add lf in the end of file

" Ident
  set tabstop=2                      " Number of spaces that a tab counts for
  set shiftwidth=2                   " Number of spaces to use for each step of (auto)indent
  set expandtab                      " Use spaces instead of tab
  set autoindent                     " Copy indent from current line when starting a new line
  set smartindent                    " Only available when compiled with the +smartindent feature
  set list lcs=tab:▸\ ,eol:¬,trail:· " Show invisibles

" Search
  set incsearch       " Find the next match as we type the search
  set hlsearch        " Highlight searches by default
  set ignorecase      " Ignore case when searching...

" Disable <Arrow keys>
  inoremap <Up> <NOP>
  inoremap <Down> <NOP>
  inoremap <Left> <NOP>
  inoremap <Right> <NOP>
  noremap <Up> <NOP>
  noremap <Down> <NOP>
  noremap <Left> <NOP>
  noremap <Right> <NOP>

" Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" A syntax highlighting file for JSON
  com! FormatJSON %!python -m json.tool

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

  " Move visual block
     vnoremap J :m '>+1<CR>gv=gv
     vnoremap K :m '<-2<CR>gv=gv

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

  " ,p
      " Toggle the 'paste' option
      set pastetoggle=<Leader>p

  " ,s
      " Shortcut for :%s//
      nnoremap <leader>s :<C-u>%s//<left>
      vnoremap <leader>s :s//<left>

  " Create a new window relative to the current one
      nnoremap <Leader><left>  :<C-u>leftabove  vnew<CR>
      nnoremap <Leader><right> :<C-u>rightbelow vnew<CR>
      nnoremap <Leader><up>    :<C-u>leftabove  new<CR>
      nnoremap <Leader><down>  :<C-u>rightbelow new<CR>

  " Can be typed even faster than
    :imap jk <Esc>
    :vmap jk <Esc>

" Plugins
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'
  Bundle 'tpope/vim-fugitive'
  Bundle 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  Bundle 'Raimondi/delimitMate'
  Bundle 'scrooloose/syntastic'
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_args = "--no-eslintrc --config ~/.dotfiles/.eslintrc"
  Bundle 'altercation/vim-colors-solarized'
    syntax enable
    let g:solarized_termcolors=16
    set background=light
    colorscheme solarized
  Bundle 'gorodinskiy/vim-coloresque'
  Bundle 'scrooloose/nerdtree'
    nnoremap <Bs> :<C-u>NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=0
    let NERDTreeMinimalUI=1
    map <C-n> :NERDTreeToggle<CR>
  Bundle 'ervandew/supertab'
  Bundle 'bling/vim-airline'
    let g:airline_theme='solarized'
    let g:airline#extensions#tabline#fnamemod = ':t'  " Display only filename in tab
    let g:airline_section_x = ''                      " Don't display filetype
    let g:airline_section_y = ''                      " Don't display encoding
    let g:airline_left_sep = ''                       " Set custom left separator
    let g:airline_right_sep = ''                      " Set custom right separator
    let g:airline#extensions#tabline#enabled = 0      " Don't display tabs
    let g:airline#extensions#tabline#show_buffers = 0 " Don't display buffers in tab-bar with single tab
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'tpope/vim-surround'
  Bundle 'godlygeek/tabular'
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  Bundle 'vim-scripts/UltiSnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>" " :UltiSnipsAddFiletypes css
    au FileType css :UltiSnipsAddFiletypes css
    au FileType javascript :UltiSnipsAddFiletypes javascript
    au FileType html :UltiSnipsAddFiletypes html
  Bundle 'iamvlado/useful-vim-snippets'
  Bundle 'jszakmeister/vim-togglecursor'
  Bundle 'othree/html5.vim'
  Bundle 'mattn/emmet-vim'
    imap EE <C-y>,
  Bundle 'hail2u/vim-css3-syntax'
  Bundle 'ap/vim-css-color'
  Bundle 'pangloss/vim-javascript'
  Bundle 'mxw/vim-jsx'
    let g:jsx_ext_required = 0
  Bundle 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled=1 " Disable Folding
  Bundle 'digitaltoad/vim-jade'
    au BufNewFile,BufReadPost *.jade set filetype=jade

  filetype plugin indent on
