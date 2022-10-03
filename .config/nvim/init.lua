require('plugins')
require('lsp-configs')

----------------------
-- GENERAL
----------------------

vim.opt.nocompatible=true
vim.cmd('scriptencoding utf8')
vim.opt.encoding='utf-8'
vim.cmd('filetype plugin indent on')

vim.opt.autoread=true
vim.opt.history=1000

-----------------------
-- HANDLING
-----------------------

vim.opt.so=10
vim.opt.ruler=true
vim.opt.wildmenu=true

-- searching
vim.opt.incsearch=true
vim.opt.hlsearch=true
-- brackets
vim.opt.showmatch=true

-- folding
vim.opt.foldlevelstart=3

------------------------
-- APPEREANCE
------------------------

vim.cmd('syntax enable')

vim.opt.t_Co=256
vim.cmd('hi LineNr ctermfg=0 ctermbg=8 cterm=NONE')

-- cursor
vim.cmd('hi CursorColumn ctermbg=237 cterm=NONE')
vim.cmd('hi CursorLine ctermbg=237 cterm=NONE')

vim.cmd([[
augroup activewindowcursorline
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup end
--set cursorline
--set cursorcolumn
]])

--status line
vim.opt.laststatus=2
vim.cmd('hi StatusLine ctermfg=220 ctermbg=8 cterm=NONE')
vim.cmd('hi StatusLineNC ctermfg=black ctermbg=8 cterm=NONE')

vim.cmd('hi VertSplit ctermbg=0 ctermfg=8')
vim.cmd('hi ColorColumn ctermbg=8')

vim.cmd('hi Search ctermbg=220 cterm=NONE')

-- line numbers
vim.opt.number=true
vim.opt.numberwidth=5

-----------------------
-- EDITING
-----------------------

--tabstop
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.smarttab=true

----------------------
-- KEYBINDINGS
----------------------

-- helper functions
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

local function cmap(shortcut, command)
  map('c', shortcut, command)
end

local function tmap(shortcut, command)
  map('t', shortcut, command)
end

------ basic maps ------

-- open ranger as a file chooser using the function below
nmap('<leader>r', ':call <SID>ranger()<CR>')
-- window switching
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')

-- code completion / navigation
vim.opt('inoremap <expr> <CR>        pumvisible() ? "\\<C-y>" : "\\<CR>"')
vim.opt('inoremap <expr> <C-j>       pumvisible() ? "\\<C-n>" : "\\<Down>"')
vim.opt('inoremap <expr> <C-k>       pumvisible() ? "\\<C-p>" : "\\<Up>"')
vim.opt('inoremap <expr> <C-h> "\\<Left>"')
vim.opt('inoremap <expr> <C-l> "\\<Right>"')

---------------------
-- EXTENSIONS
---------------------

--nesc
vim.cmd([[
augroup filetypedetect
	au! BufRead,BufNewFile *nc setfiletype nc
augroup end
]])

map('', '<C-c>', ':pyf /usr/share/clang/clang-format.py<cr>')
imap('<C-c>', '<c-o>:pyf /usr/share/clang/clang-format.py<cr>')

---------------------
-- COMMANDS
---------------------

vim.cmd([[
function! TrimTrailingWhitespaces()
	let l:save = winsaveview()
	%s/\s\+$//e
	cal winrestview(l:save)
endfunction
command! TT call TrimTrailingWhitespaces()
]])

--------------------
-- NAVIGATION
--------------------

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20
vim.g.netrw_list_hide = '.*\\.swp$,^\\.git\\/$'

--augroup projecttree
--    autocmd!
--    autocmd VimEnter * :Vexplore
--    au FileType netrw au BufCreate <buffer> :set wfw
--augroup end

--------------------
-- MISC
--------------------

vim.opt.autochdir=true
vim.opt.c_no_curly_error = 1

