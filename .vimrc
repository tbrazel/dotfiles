" function GetSelectedText()
"  normal gv"xy
"  let @x = @x . 'more'
"  let result = getreg("x")
"    normal gv
"  return result
" endfunc

" vnoremap <C-q> :call GetSelectedText()<CR>



" Much of this was borrowed from https://github.com/dicai/dotfiles/blob/master/vimrc


call has('python3')
set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/Python
set pythonthreehome=/Library/Frameworks/Python.framework/Versions/3.6
" set pythondll=libpython3.8.so
""""""""""""""""""""
" Visual appearance
""""""""""""""""""""

" Fix swap file issues
set shortmess+=A

" Enable syntax highlighting
syntax on

" Show line numbers
set number


" Invisible vertical split line.
set fillchars+=vert:\

" Make things faster.
set lazyredraw


" Show status line
set laststatus=2

" Show full path to file in status line
set statusline=%F

" Match indent of previous line
set autoindent

" Backspace more powerful
set backspace=indent,eol,start

" Wordwrap
set wrap
set linebreak
set breakat=" "
set textwidth=0
set wrapmargin=0

" Show matches while searching, ignore case
set incsearch
set ignorecase
set smartcase

" Switch buffers without saving.
set hidden

" Tab in command mode displays all completions.
set wildmenu

" Ignore filetypes in tab completion.
set wildignore+=*.aux,*.log,*.out,*.pdf

" Start scrolling 3 lines from border.
set scrolloff=1

" Left and right arrows go between lines
set whichwrap+=<,>,h,l,[,]

" Matching brace (e.g. begin.. end..)
set showmatch

" Keep working dir clean
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Sudo
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
" Split
"""

" Mapleader shortcuts, set leader to be a single apostrophe
let mapleader="'"

" Create new split and switch to it, with 'w and 's
nnoremap <Leader>w <C-w>v<C-w>l
nnoremap <Leader>s <C-w>s<C-w>j

" Close split with 'c
nnoremap <Leader>c <C-w>c

" Easier movement in split windows.
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Calls (saves first) make
nnoremap <Leader>m :w\|silent make\|redraw!\|cc<CR>

" Quick toggle of diff mode.
nnoremap <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        diffoff
    else
        diffthis
    endif
:endfunction

"""
" Other mappings
"""

" Saving shortcut, ctrl-W in normal mode
nnoremap <C-W> :w <CR>


" Delete highlighted text in VISUAL mode
vmap <Bs> d

" Synctex
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/ultisnips
set rtp+=~/.vim/bundle/vim-colorschemes
set rtp+=~/.config/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" if has('nvim')
"   Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plugin 'Shougo/deoplete.nvim'
"   Plugin 'roxma/nvim-yarp'
"   Plugin 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

Plugin 'lervag/vimtex'
    " Recognize .tex files as latex (instead of plaintex) for syntax highlighting
    let g:tex_flavor = 'latex' 
    " Disable vimtex
    let g:vimtex_enabled=0
    let g:latex_indent_enabled = 0
    " Don't highlight underscores and other stuff
    let g:tex_no_error=1

 
Plugin 'honza/vim-snippets'
Plugin 'sirver/ultisnips'
	let g:UltiSnipsSnippetsDirectories = ["mycustomsnippets"]
	let g:UltiSnipsUsePythonVersion = 3
	let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsRemoveSelectModeMappings = 0
    let g:UltiSnipsEditSplit = 'vertical'



Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/syntastic'

" Anderson colorscheme
Plugin 'gilgigilgil/anderson.vim'

" Spacecamp colorscheme
" Plugin 'jaredgorski/spacecamp'
" Preferred colorscheme
" colorscheme mod8
" set guifont=Monaco:h13


" In normal mode gcc comments out a line
" In visual mode gc comments out a selection
Plugin 'tpope/vim-commentary'

" nerdtree file navigator, opens with ctrl-n
Plugin 'scrooloose/nerdtree'
" show dotfiles
    let NERDTreeShowHidden=1

" Open nerdtree with Control-n
    map <C-n> :NERDTreeToggle<CR>

call vundle#end()           " required



filetype plugin indent on   " required

" let g:vimtex_complete_enabled=1
"Integrate vimtex into depoplete
" call deoplete#custom#var('omni', 'input_patterns', {
"      \ 'tex': g:vimtex#re#deoplete
"      \})



" let g:deoplete#enable_at_startup = 0

                                                

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


filetype plugin on

" Integrate Vimtex
 " call deoplete#custom#var('omni', 'input_patterns', {
 "       \ 'tex': g:vimtex#re#deoplete
 "       \})

 " let g:deoplete#disable_auto_complete = 1
 " function! HandleTab() abort
 "   " First, try to expand or jump on UltiSnips.
 "   call UltiSnips#ExpandSnippetOrJump()
 "   if g:ulti_expand_or_jump_res > 0
 "     return ""
 "   endif
 "   " Then, check if we're in a completion menu
 "   if pumvisible()
 "     return "\<C-n>"
 "   endif
 "   " Then check if we're indenting.
 "   let col = col('.') - 1
 "   if !col || getline('.')[col - 1] =~ '\s'
 "     return "\<Tab>"
 "   endif
 "   " Finally, trigger deoplete completion.
 "   return deoplete#manual_complete()
 " endfunction

 " inoremap <silent> <Tab> <C-R>=HandleTab()<CR>




" Control-r refreshes snippets
nmap <buffer> <C-R> :call UltiSnips#RefreshSnippets()<CR>


" Set the make program (rubber)
autocmd FileType tex set makeprg=rubber\ --inplace\ --maxerr\ 1\ \ --pdf\ --short\ --quiet\ --force\ %
" Mappings for compiling Latex file
" Compile 
autocmd FileType tex nmap <buffer> <C-T> :term++close latexmk -bibtex -synctex=1 -pdf %<CR>
" autocmd FileType tex nmap <buffer> <C-T> :term++close pdflatex -synctex=1 -pdf %<CR>
autocmd FileType tex nmap <buffer> <C-B> :term++close bibtex %<CR>

" Clear aux files
autocmd FileType tex nmap <buffer> <C-C> :!latexmk -c %<CR>

" Open PDF
autocmd FileType tex nmap <buffer> T :!open -a Skim %<.pdf %<.pdf<CR><CR>
autocmd FileType tex nmap <buffer> C :!rubber --clean<CR>

" Don't unindent when colon is entered
autocmd FileType tex,latex setlocal indentkeys-=:

" Fix wrapping issue
autocmd FileType tex set textwidth=0

autocmd FileType tex setlocal spell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off colorcolumn in diff mode.
autocmd FilterWritePre * if &diff | set cc= | endif

" Skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e



""""""""""""""""
" Other custom commands
""""""""""""""""

" Enable synctex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
endfunction

" Call synctex forward with 'f
nmap <Leader>f :call SyncTexForward()<CR>

" Remember folds on save
augroup AutoSaveFolds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent loadview 1
augroup END

" Fix local typos by spellcheck with control-L
" From https://castel.dev/post/lecture-notes-1/
set spell
setlocal spell
set spellfile=$HOME/.vim/spell/en.utf-8.add
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

set nornu


" See https://stackoverflow.com/questions/26917336/vim-specific-mkview-and-loadview-in-order-to-avoid-issues
set viewoptions-=options
set sessionoptions-=options


"""""""""
" Tabs
"""""""""


imap <D-1> <Esc>1gti
imap <D-2> <Esc>2gti
imap <D-3> <Esc>3gti
imap <D-4> <Esc>4gti
imap <D-5> <Esc>5gti
imap <D-6> <Esc>6gti
imap <D-7> <Esc>7gti
imap <D-8> <Esc>8gti

nmap <D-1> 1gti
nmap <D-2> 2gti
nmap <D-3> 3gti
nmap <D-4> 4gti
nmap <D-5> 5gti
nmap <D-6> 6gti
nmap <D-7> 7gti
nmap <D-8> 8gti


""""""""""
" Typo correction
""""""""""

iab hte the
iab teh the
iab taht that
iab htat that
iab THe The
iab THen Then
iab THey They
iab THis This
iab THat That
iab THese These
iab THere There
iab THose Those
iab WHen When
iab SInce Since
iab jsut just
iab FOr For
iab codt cdot
iab inveritble invertible

set rtp^=$HOME
set tabstop=4 softtabstop=-1 shiftwidth=0 expandtab


" #########################################################
" # A way to delete 'mkview'
" See https://stackoverflow.com/questions/28384159/vim-how-to-remove-clear-views-created-by-mkview-from-inside-of-vim
function! MyDeleteView()
	let path = fnamemodify(bufname('%'),':p')
	" vim's odd =~ escaping for /
	let path = substitute(path, '=', '==', 'g')
	if empty($HOME)
	else
		let path = substitute(path, '^'.$HOME, '\~', '')
	endif
	let path = substitute(path, '/', '=+', 'g') . '='
	" view directory
	let path = &viewdir.'/'.path
	call delete(path)
	echo "Deleted: ".path
endfunction
command Delview call MyDeleteView()

" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

" Disable all filetype indentation
filetype indent off


