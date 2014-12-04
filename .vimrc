" a lot of these configs derive
" from github.com/dahu/LearnVim
syntax on
set number
set ruler
set visualbell
set nocompatible
filetype plugin indent on
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

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" .tex -> .pdf on every write
autocmd BufWritePost *.tex !pdflatex %

command WQ wq
command Wq wq
command W w
command Q q
