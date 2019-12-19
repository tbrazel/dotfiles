" function GetSelectedText()
"  normal gv"xy
"  let @x = @x . 'more'
"  let result = getreg("x")
"    normal gv
"  return result
" endfunc

" vnoremap <C-q> :call GetSelectedText()<CR>



" Much of this was borrowed from https://github.com/dicai/dotfiles/blob/master/vimrc


""""""""""""""""""""
" Visual appearance
""""""""""""""""""""


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
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
	let g:UltiSnipsSnippetsDirectories = ["mycustomsnippets"]
	let g:UltiSnipsUsePythonVersion = 3
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsRemoveSelectModeMappings = 0
    let g:UltiSnipsEditSplit = 'vertical'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/syntastic'

" Anderson colorscheme
Plugin 'gilgigilgil/anderson.vim'

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


" Plugin 'lervag/vimtex'
"	let g:vimtex_view_method='skim'
"	let g:vimtex_quickfix_mode=0
"        let g:vimtex_indent_on_ampersands = 0
"        let g:vimtex_motion_enabled = 0
        " disable latex autindentation
" let g:vimtex_matchparen_enabled = 0     
" let g:matchup_matchparen_deferred = 1     
" let g:vimtex_matchparen_enabled = 0

call vundle#end()
filetype plugin indent on

                                                

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on

" Recognize .tex files as latex (instead of plaintex) for syntax highlighting.
let g:tex_flavor="latex"

let g:latex_indent_enabled = 0

" Don't highlight underscores and other stuff
let g:tex_no_error=1

" Set the make program (rubber)
autocmd FileType tex set makeprg=rubber\ --inplace\ --maxerr\ 1\ \ --pdf\ --short\ --quiet\ --force\ %
" Mappings for compiling Latex file

" Compile silently
autocmd FileType tex nmap <buffer> <C-T> :silent !latexmk -synctex=1 -pdf %<CR>

" Compile with info
autocmd FileType tex nmap <buffer> <C-I> :!latexmk -synctex=1 -pdf %<CR>

" Clear aux files
autocmd FileType tex nmap <buffer> <C-C> :!latexmk -c %<CR>

" Open PDF
autocmd FileType tex nmap <buffer> T :!open -a Skim %<.pdf %<.pdf<CR><CR>
autocmd FileType tex nmap <buffer> C :!rubber --clean<CR>

" Don't unindent when colon is entered
autocmd FileType tex,latex setlocal indentkeys-=:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off colorcolumn in diff mode.
autocmd FilterWritePre * if &diff | set cc= | endif

" Skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Fix wrapping issue
autocmd FileType tex    set textwidth=0


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
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Fix local typos by spellcheck with control-L
" From https://castel.dev/post/lecture-notes-1/
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" See https://stackoverflow.com/questions/26917336/vim-specific-mkview-and-loadview-in-order-to-avoid-issues
set viewoptions-=options
set sessionoptions-=options

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
