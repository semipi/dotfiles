""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""

set nocompatible
scriptencoding utf-8
set encoding=utf-8

filetype plugin indent on

set autoread
set history=1000

"""""""""""""""""""""""
" HANDLING
"""""""""""""""""""""""

set so=10
set ruler
set wildmenu

" searching
set incsearch
set hlsearch
" brackets
set showmatch

" folding
set foldlevelstart=3

""""""""""""""""""""""""
" APPEREANCE
""""""""""""""""""""""""

syntax enable

set t_Co=256
hi LineNr ctermfg=0 ctermbg=8 cterm=NONE

" cursor
hi CursorColumn ctermbg=237 cterm=NONE
hi CursorLine ctermbg=237 cterm=NONE

augroup activewindowcursorline
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup end
"set cursorline
"set cursorcolumn

"status line
set laststatus=2
hi StatusLine ctermfg=220 ctermbg=8 cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=8 cterm=NONE

hi VertSplit ctermbg=0 ctermfg=8
hi ColorColumn ctermbg=8

hi Search ctermbg=220 cterm=NONE

" line numbers
set number
set numberwidth=5

"""""""""""""""""""""""
" EDITING
"""""""""""""""""""""""

"tabstop
set tabstop=4 shiftwidth=4 expandtab smarttab

""""""""""""""""""""""
" KEYBINDINGS
""""""""""""""""""""""

" window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" code completion / navigation
inoremap <expr> <CR>        pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j>       pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-h> "\<Left>"
inoremap <expr> <C-l> "\<Right>"

"""""""""""""""""""""
" EXTENSIONS
"""""""""""""""""""""

"nesc
augroup filetypedetect
	au! BufRead,BufNewFile *nc setfiletype nc
augroup end

"""""""""""""""""""""
" COMMANDS
"""""""""""""""""""""

function! TrimTrailingWhitespaces()
	let l:save = winsaveview()
	%s/\s\+$//e
	cal winrestview(l:save)
endfunction
command! TT call TrimTrailingWhitespaces()

""""""""""""""""""""
" NAVIGATION
""""""""""""""""""""

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_list_hide = '.*\.swp$,^\.git\/$'

augroup projecttree
    autocmd!
    autocmd VimEnter * :Vexplore
    au FileType netrw au BufCreate <buffer> :set wfw
augroup end

""""""""""""""""""""
" MISC
""""""""""""""""""""

set autochdir
let c_no_curly_error = 1

