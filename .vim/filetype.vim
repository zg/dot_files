if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
  au! BufNewFile,BufRead *.md setf mkd
  au! BufNewFile,BufRead *.prolog setf prolog
augroup END
