call plug#begin('~/.vim/plugged')
" ... your other plugins

Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
"Plug 'https://github.com/ActivityWatch/aw-watcher-vim.git'

call plug#end()

" Vim CodeStats plugin
" REQUIRED: set your API key
let g:codestats_api_key = $DT_CODESTATS_API_KEY
" Optional: configure vim-airline to display status
let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '%{CodeStatsXp()}'])

" Custom command :Sw to save and write file as superuser
command! -nargs=0 Sw w !sudo tee % > /dev/null

" Settings
set tabstop=4                  " tab stops at 4 spaces
set shiftwidth=4               " default shift
set expandtab                  " default tabs

" Syntax
" nginx
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
" yaml indentation
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
