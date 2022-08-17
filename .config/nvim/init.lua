require('plugins')
require('lsp-configs')

-- Sane vim defaults for ArchLabs
vim.cmd('scriptencoding utf8')

-- Arch defaults
vim.cmd('runtime! archlinux.vim')

-- system clipboard (requires +clipboard)
vim.opt.clipboard.prepend("unnamed,unnamedplus")

-- additional settings
vim.opt.modeline=true -- enable vim modelines
vim.opt.hlsearch=true -- highlight search items
vim.opt.incsearch=true -- searches are performed as you type
vim.opt.number=true -- enable line numbers
vim.opt.confirm=true -- ask confirmation like save before quit.
vim.opt.wildmenu=true -- Tab completion menu when using command mode
vim.opt.expandtab=true -- Tab key inserts spaces not tabs
vim.opt.softtabstop=4 -- spaces to enter for each tab
vim.opt.shiftwidth=4 -- amount of spaces for indentation
vim.opt.shortmess.append("aAcIws") -- Hide or shorten certain messages

vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3

------ leader mapping ------
vim.g.mapleader = "\\<Space>"

------ enable additional features ------

-- enable mouse
vim.opt.mouse=a
if vim.fn.has('mouse_sgr') == 1 then
    -- sgr mouse is better but not every term supports it
    vim.opt.ttymouse='sgr'
end

vim.opt.linebreak=true
vim.opt.breakindent=true
vim.opt.list=true
vim.cmd('listchars=tab:>>,trail:~')

-- TODO install jinx if you want it
-- midnight, night, or day
-- vim.g.jinx_theme = 'midnight'
-- colorscheme jinx

vim.cmd('colorscheme slate')

vim.cmd([[
	if $TERM !=? 'linux'
		set termguicolors
		" true colors in terminals (neovim doesn't need this)
		if !has('nvim') && !($TERM =~? 'xterm' || &term =~? 'xterm')
			let $TERM = 'xterm-256color'
			let &term = 'xterm-256color'
		endif
		if has('multi_byte') && $TERM !=? 'linux'
			set listchars=tab:»»,trail:•
			set fillchars=vert:┃ showbreak=↪
		endif
	endif
]])

------ commands ------

vim.cmd([[
command! D Explore
command! R call <SID>ranger()
command! Q call <SID>quitbuffer()
command! -nargs=1 B :call <SID>bufferselect("<args>")
command! W execute 'silent w !sudo tee % >/dev/null' | edit!
]])

-- maps helpers functions
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

-- match string to switch buffer
nmap('<Leader>b', ':let b:buf = input('Match: ')<Bar>call <SID>bufferselect(b:buf)<CR>')

-- change windows with ctrl+(hjkl)
nmap('<C-J>', '<C-W><C-J>')
nmap('<C-K>', '<C-W><C-K>')
nmap('<C-L>', '<C-W><C-L>')
nmap('<C-H>', '<C-W><C-H>')

-- alt defaults
nmap('0', '^')
nmap('Y', 'y$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('<Tab>', '==1j')

-- re-visual text after changing indent
vmap('>', '>gv')
vmap('<', '<gv')

-- toggle line numbers, nn (no number)
nmap('<Leader>nn', ':set number!')

-- gj/k but preserve numbered jumps ie: 12j or 45k
vim.cmd([[
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'
]])

-- open a terminal in $PWD
nmap('<Leader>tt', ':terminal<CR>')

-- tab control
nmap('<silent>', '<M-j> :tabmove -1<CR>')
nmap('<silent>', '<M-k> :tabmove +1<CR>')
nmap('<silent>', '<Leader>te :tabnew<CR>')
nmap('<silent>', '<Leader>tn :tabnext<CR>')
nmap('<silent>', '<Leader>tf :tabfirst<CR>')
nmap('<silent>', '<Leader>tp :tabprevious<CR>')

-- close current buffer and/or tab
nmap('<Leader>q', ':B<CR>:silent tabclose<CR>gT')

-- open a new tab in the current directory with netrw
nmap('<Leader>-', ':tabedit <C-R>=expand("%:p:h")<CR><CR>')

-- split the window vertically and horizontally
nmap('_', '<C-W>s<C-W><Down>')
nmap('<Bar>', '<C-W>v<C-W><Right>')

------ autocmd ------

-- Reload changes if file changed outside of vim requires autoread
vim.cmd([[
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END
]])

-- when quitting a file, save the cursor position
vim.cmd([[
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
]])

-- when not running in a console or a terminal that doesn't support 256 colors
-- enable cursorline in the currently active window and disable it in inactive ones
vim.cmd([[
if $DISPLAY !=? '' && &t_Co == 256
    augroup cursorline
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif
]])

------ adv maps ------

-- strip trailing whitespace, ss (strip space)
vim.cmd([[
nnoremap <silent> <Leader>ss
    \ :let b:_p = getpos(".") <Bar>
    \  let b:_s = (@/ != '') ? @/ : '' <Bar>
    \  %s/\s\+$//e <Bar>
    \  let @/ = b:_s <Bar>
    \  nohlsearch <Bar>
    \  unlet b:_s <Bar>
    \  call setpos('.', b:_p) <Bar>
    \  unlet b:_p <CR>
]])

-- global replace
vim.cmd([[
vnoremap <Leader>sw "hy
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep."/".b:sub.'/g' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>
]])

vim.cmd([[
nnoremap <Leader>sw
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/g' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>
]])

-- prompt before each replace
vim.cmd([[
vnoremap <Leader>cw "hy
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep.'/'.b:sub.'/gc' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>
]])

vim.cmd([[
nnoremap <Leader>cw
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/gc' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>
]])

-- highlight long lines, ll (long lines)
vim.cmd([[
let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth)
nnoremap <silent> <Leader>ll
    \ :if exists('w:longlines') <Bar>
    \   silent! call matchdelete(w:longlines) <Bar>
    \   echo 'Long line highlighting disabled'
    \   <Bar> unlet w:longlines <Bar>
    \ elseif &textwidth > 0 <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> else <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%80v', 81) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> endif <CR>
]])

-- local keyword jump
vim.cmd([[
nnoremap <Leader>fw
    \ [I:let b:jump = input('Go To: ') <Bar>
    \ if b:jump !=? '' <Bar>
    \   execute "normal! ".b:jump."[\t" <Bar>
    \   unlet b:jump <Bar>
    \ endif <CR>
]])

-- quit the current buffer and switch to the next
-- without this vim will leave you on an empty buffer after quiting the current

vim.cmd([[
function! <SID>quitbuffer() abort
    let l:bf = bufnr('%')
    let l:pb = bufnr('#')
    if buflisted(l:pb)
        buffer #
    else
        bnext
    endif
    if bufnr('%') == l:bf
        new
    endif
    if buflisted(l:bf)
        execute('bdelete! ' . l:bf)
    endif
endfunction
]])

-- switch active buffer based on pattern matching
-- if more than one match is found then list the matches to choose from
vim.cmd([[
function! <SID>bufferselect(pattern) abort
    let l:bufcount = bufnr('$')
    let l:currbufnr = 1
    let l:nummatches = 0
    let l:matchingbufnr = 0
    " walk the buffer count
    while l:currbufnr <= l:bufcount
        if (bufexists(l:currbufnr))
            let l:currbufname = bufname(l:currbufnr)
            if (match(l:currbufname, a:pattern) > -1)
                echo l:currbufnr.': '.bufname(l:currbufnr)
                let l:nummatches += 1
                let l:matchingbufnr = l:currbufnr
            endif
        endif
        let l:currbufnr += 1
    endwhile

    " only one match
    if (l:nummatches == 1)
        execute ':buffer '.l:matchingbufnr
    elseif (l:nummatches > 1)
        " more than one match
        let l:desiredbufnr = input('Enter buffer number: ')
        if (strlen(l:desiredbufnr) != 0)
            execute ':buffer '.l:desiredbufnr
        endif
    else
        echoerr 'No matching buffers'
    endif
endfunction
]])

-- open ranger as a file chooser
vim.cmd([[
function! <SID>ranger()
    let l:temp = tempname()
    execute 'silent !xterm -e ranger --choosefiles='.shellescape(l:temp).' $PWD'
    if !filereadable(temp)
        redraw!
        return
    endif
    let l:names = readfile(l:temp)
    if empty(l:names)
        redraw!
        return
    endif
    execute 'edit '.fnameescape(l:names[0])
    for l:name in l:names[1:]
        execute 'argadd '.fnameescape(l:name)
    endfor
    redraw!
endfunction
]])

vim.cmd('filetype plugin indent on')

vim.cmd([[
function! TrimTrailingWhitespaces()
    let l:save = winsaveview()
    %s/\s\+$//e
    cal winrestview(l:save)
endfunction
command! TT call TrimTrailingWhitespaces()
]])

vim.cmd([[
if $SSH_CONNECTION
    colorscheme jinx
endif
]])

-- code completion / navigation
--inoremap <expr> <C-j>       pumvisible() ? "\<C-n>" : "\<Down>"
--inoremap <expr> <C-k>       pumvisible() ? "\<C-p>" : "\<Up>"
--inoremap <expr> <C-h> "\<Left>"
--inoremap <expr> <C-l> "\<Right>"
