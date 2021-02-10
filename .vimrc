" don't emulate vi
set nocompatible

" search files in subfolders as well
set path+=**

" display all files that match your search
set wildmenu

" encoding and history
set encoding=utf8
set history=500

" some indenting stuff, like autoindent and tab width
set autoindent
set expandtab
set smarttab

set shiftwidth=4
set tabstop=4

" line number on the side, relative to current line
set number
set relativenumber

" show the command that you're typing at the bottom
set showcmd

" syntax
syntax enable

" filetype
filetype plugin on
filetype indent on

" custom snippets
" for future me: everything after <CR> is optional to you
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a


