" General
syntax on
set number
set relativenumber
set cursorline
set showmatch
set encoding=utf-8
set history=500

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Visual
set laststatus=2
set ruler
set showcmd
set wildmenu
set scrolloff=5

" YAML / Ansible specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml  setlocal ts=2 sts=2 sw=2 expandtab

" Disable swap files
set noswapfile
set nobackup
