" a lot of these configs derive
" from github.com/dahu/LearnVim
syntax on
set number
set ruler
set visualbell
set nocompatible
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set laststatus=2
set backspace=indent,eol,start
set autoindent
set nostartofline
set nopaste
set pastetoggle=<f11>
set wildmenu
set wildmode=longest:full,full
set showcmd
set cmdheight=2
set t_vb=
set mouse=a
set fileencoding=utf-8
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set viminfo+=n~/.vim/tmp/viminfo
set undodir=~/.vim/tmp/

set paste

filetype plugin indent on

highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', -1)

" .tex -> .pdf on every write
autocmd BufWritePost *.tex !pdflatex %

" enter working directory of current file
autocmd BufEnter * silent! lcd %:p:h

" indent by two spaces for a few types
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2

command E e
command WQ wq
command Wq wq
command W w
command Q q
