syntax on
set nocompatible
" set term=xterm-256color " no such option in neovim
set mouse-=a " selecting with mouse without v-isual mode
" set mouse+=a " selecting with mouse enters v-isual mode
" set number " show line numbers
set clipboard^=unnamed,unnamedplus " copy yanked text also to system clipboard
set autoindent " always set autoindenting on"
set paste " turn off autoindent when pasting
set smartindent " use smart indent if there is no indent file"
set tabstop=4 " <tab> inserts 4 spaces"
set softtabstop=4 " <BS> over an autoindent deletes 4 spaces."
set smarttab " Handle tabs more intelligently"
set noexpandtab
set shiftwidth=4 " an indent level is 4 spaces wide."
set shiftround " rounds indent to a multiple of shiftwidth

