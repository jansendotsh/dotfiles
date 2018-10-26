execute pathogen#infect()
syntax on
filetype plugin indent on
color dracula
" set termguicolors
let g:dracula_colorterm = 0
set number
" Testing VimWiki instead of SimpleNote
nnoremap <Space> za
let wiki_1 = {}
let wiki_1.path = '/mnt/c/Users/janseng/Documents/vimwiki'
let wiki_1.nested_syntaxes = {'python': 'python'}
let g:vimwiki_list = [wiki_1]

