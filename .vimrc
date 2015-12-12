set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'tpope/vim-sensible'
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'

Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-rails'

Plugin 'underlog/vim-PairTools'

Plugin 'bufexplorer.zip'
Bundle 'Shougo/neocomplcache'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

Plugin 'underlog/vim-snippets'

Plugin 'chriskempson/base16-vim'
Plugin 'groenewege/vim-less'

Plugin 'vim-scripts/JavaScript-Indent'

Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'

Plugin 'matthias-guenther/hammer.vim'

Plugin 'itchyny/lightline.vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-dispatch'

call vundle#end()            " required
filetype plugin indent on    " required

nnoremap <F9>  :bw<CR>
nnoremap <F7>  :nohlsearch<CR>
nnoremap <F8> :setlocal spell! spell?<CR>
nnoremap <F12> :BufExplorer<CR>
nnoremap ,d /<C-r><C-w>:<space>function<CR>
inoremap <F12> <Esc>:BufExplorer<CR>

set hidden

set lazyredraw
set showmode
set novisualbell
cnoremap <C-n> <Up>

set wildmode=list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

set background=dark
colorscheme base16-default

" indent helpers
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" 4 spaces indent, as JS wants it
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab smartindent

set number

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" gui options
set guifont=Consolas:h11
" set guifont=Anonymice\ Powerline:h12

set anti

" set guifont=Monaco:h10
" set noanti
set linespace=1
" set guioptions=aci

" command line options
set t_Co=256
set mouse=a
set ttymouse=xterm2

set wildignore+=deploy/**,dist/**,release/**,*.min.js,*.js.map

" Remember last location in file
if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

    " cleanup whitespace
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufReadPost *cshtml set filetype=html
    autocmd BufReadPost Jakefile set filetype=javascript
    autocmd FileType gitcommit setlocal spell
endif

" Use modeline overrides
set modeline
set noswapfile
set modelines=10
set hls!
set autochdir
" Directories for swp/undo files

set undofile
set nobackup
set nowritebackup

set undodir=~/.vim/undo
set backupdir=~/.vim/backup
set directory=~/.vim/swp

"hide the menu
set guioptions-=M
set guioptions-=T

let mapleader=" "
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>ev :e $MYVIMRC<cr>
nnoremap <Leader>sv :so $MYVIMRC<cr>

"use C-s for saving
noremap <C-S> :w<CR>

let g:neocomplcache_enable_at_startup = 1
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsDontReverseSearchPath=1

" lightline stuff
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
