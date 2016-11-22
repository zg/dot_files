" a lot of these configs derive
" from github.com/dahu/LearnVim
syntax on
set number
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c/%L,%l/%L\ %P
set visualbell
set nocompatible
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set laststatus=2
set backspace=indent,eol,start
set nostartofline
set pastetoggle=<f11>
set wildmenu
set wildmode=longest:full,full
set showcmd
set cmdheight=2
set t_vb=
set mouse=""
set clipboard=unnamed
set fileencoding=utf-8
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set viminfo+=n~/.vim/tmp/viminfo
set undodir=~/.vim/tmp/

execute pathogen#infect()

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

map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >
map . /
