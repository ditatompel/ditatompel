" Custom command :Sw to save and write file as superuser
command! -nargs=0 Sw w !sudo tee % > /dev/null

" Settings
set modeline
set tabstop=4                  " tab stops at 4 spaces
set shiftwidth=4               " default shift
set expandtab                  " default tabs

" Set to auto read when a file is changed from the other session
set autoread
au FocusGained,BufEnter * silent! checktime

" Turn backup file off
set nobackup
set nowb
set noswapfile

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Syntax
syntax enable
" nginx
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
" yaml indentation
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
