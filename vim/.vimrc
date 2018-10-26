execute pathogen#infect()
syntax on
filetype plugin indent on
color dracula
set number

" SimpleNote
let g:SimplenoteUsername = "garrett.jansen@gmail.com"
let g:SimplenoteSingleWindow = 1
map <C-l> :SimplenoteList<CR>

" VimWiki
let wiki_1 = {}
let wiki_1.path = '/mnt/c/Users/janseng/Documents/vimwiki'
let wiki_1.nested_syntaxes = {'python': 'python'}
let g:vimwiki_list = [wiki_1]

" Markdown settings
nnoremap <Space> za
map <F12> :Goyo<CR> :setlocal spell<CR> :SoftPencil<CR>
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md SoftPencil

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>

" Python settings
let g:pymode_python = 'python3'


