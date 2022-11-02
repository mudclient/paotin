silent! call plug#begin()
Plug 'dzpao/vim-mbs'
Plug 'morhetz/gruvbox'
Plug 'yegappan/mru'
Plug 'jlanzarotta/BufExplorer'
call plug#end()

" 不兼容 vi
set nocompatible
" 用空格代替 TAB
set expandtab
" 整体左移或者右移时，每次 4 个空格
set shiftwidth=4
" TAB 键按 4 空格对齐
set tabstop=4
set softtabstop=4
set smarttab

" 开启真彩色
set termguicolors
" 开启真彩色配色方案
colorscheme gruvbox
highlight Normal guibg=#1d2021
" 显示行号
set number
" 显示相对行号
set relativenumber
" 显示光棒
set cursorline
" 80 列高亮，提醒边界线
set colorcolumn=80

" 文件写入成功后，不保留备份文件
set nobackup
" 直接写原文件，不先建立备份
set nowritebackup
" 不要交换文件
set noswapfile

" 开启鼠标支持
set mouse=nvi

" 开启自动缩进
set cindent

" 自动识别文件编码
set fileencodings=utf8,gbk

" 始终用 utf8 显示
set encoding=utf8

" 开启 modeline 支持
set modeline

" F 开启 Buffer Explorer
nmap F :BufExplorer<CR>
nnoremap <silent> ,F F
nnoremap <silent> ,f F
autocmd BufEnter \[BufExplorer\] nmap <buffer><silent> F q

" M 开启/关闭 MRU
nmap <silent> M :MRU<CR>
nnoremap <silent> ,M M
autocmd BufEnter __MRU_Files__ nnoremap <buffer><silent> M :q<CR>
autocmd BufEnter -RecentFiles- nnoremap <buffer><silent> M :q<CR>
