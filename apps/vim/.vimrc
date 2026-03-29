set nocompatible              " be iMproved, required
filetype plugin indent on     " enable filetype-based indentation
syntax on

" Display
set nu                        " show line numbers
set relativenumber            " relative line numbers (absolute on current line)
set cursorline                " highlight current line
set scrolloff=8               " keep 8 lines above/below cursor
set showcmd                   " show partial command in status bar

" Search
set hlsearch                  " highlight search results
set incsearch                 " show matches as you type
set ignorecase                " case-insensitive search...
set smartcase                 " ...unless pattern contains uppercase

" Editing
set backspace=indent,eol,start  " make backspace work normally in insert mode

" Indentation
set expandtab                 " use spaces instead of tabs
set tabstop=2                 " tab = 2 spaces
set shiftwidth=2              " indent = 2 spaces

" Files
set noswapfile                " disable swap files
set autoread                  " reload files changed outside vim
