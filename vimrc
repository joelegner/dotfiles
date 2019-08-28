" Initial .vimrc file created 2008-01-13 by JML
"
" Requirements:
" 1. Each statement shall have an explanation of its meaning and source of
"    its meaning if known.
"
" 2. The file shall be organized into logical sections delineated by bars
"    across the screen:
"    - Compatibility
"    - Appearance
"    - Key maps
"    - Insert mode abbreviations
"    - File type specific settings
"    - File type specific skeleton files
"
" 3. Vi-style should be used in preference to Windows-style.  This is to
"    promote good habits and thereby improve efficiency.

" ==========================================================================
" Compatibility
" ==========================================================================
" Tell Pathogen to install packages found under .vim/bundle
" https://github.com/tpope/vim-pathogen
"call pathogen#infect()      " Must precede filetype plugin indent on

filetype plugin indent on   " Detect file type, enable loading the indent file
                            " for specific file type and enable loading plugin
                            " files for specific file types.
set nocompatible	" Do not behave like vi.
set noignorecase    " Do not ignore case when searching.
set backspace=indent,eol,start  " Delete indents, end of lines and starts

" Turn on spell checking by default
"setlocal spell spelllang=en_us

let $legnerjm=expand("<sfile>:p:h")

" Toggle comments using ALT-X.
" http://www.vim.org/scripts/script.php?script_id=23
" User-mode:
" Comment				        <M-x>
" Comment	+ one line down		<M-c>
" DeComment			            <M-y>
" DeComment + one line down	    <M-v>
let g:EnhCommentifyUseAltKeys = 'yes'
let g:EnhCommentifyTraditionalMode = 'N'
"source $legnerjm/plugin/imaps.vim

" These insert mode abbreviations are for all file types.
"source $legnerjm/scripts/snippets.vim
"
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" Look in current directory for tags and then work up tree to root until found
set tags=./tags;/

" Make it so VIM uses ctags file for autocomplete
set complete=.,t


" ==========================================================================
" Appearance
" ==========================================================================
set autoindent	    " Use indent of line above when starting a new line.
set expandtab		" Use (4) spaces in lieu of a tab character.
set hlsearch		" Highlight words when searching.
set incsearch		" Highlight as you type when searching.
let mapleader='\'
set number          " Show line numbers.
set ruler           " Always show cursor position in lower right corner.
set shiftwidth=4	" For moving blocks with < and > in Visual mode.
set showcmd         " Display incomplete command in lower right corner.
set showmatch		" Show matching brackets when typed.
set showmode        " Display current mode in lower left corner.
set smarttab		" Insert spaces at the beginning of a line.
set softtabstop=4	" Treat groups of (4) spaces as tabs when deleting.
set tabstop=4		" Width of a tab in characters.
set wildmenu        " Turn on wild menu
set wildmode=full
set wrap		    " Wrap long lines of text
syntax on           " Turn on syntax highlighting.
set foldenable      " Turn on folding
"Format options:
"set formatoptions=tcroql
"t	Auto-wrap text using textwidth
"c	Auto-wrap comments using textwidth.
"r	Automatically insert the current comment leader after hitting
"   <Enter> in Insert mode.
"o	Automatically insert the current comment leader after hitting 'o' or
"   'O' in Normal mode.
"q	Allow formatting of comments with "gq".
"l	Long lines are not broken in insert mode: When a line was longer than
"   'textwidth' when the insert command started, Vim does not
"    automatically format it.

" Colors
" ------
if has("win32")
    " Make highlighted text look like Windows default
    hi Visual guibg=Sys_Highlight guifg=Sys_HighlightText
else
    " Make highlighted text darker than default LightGrey
    hi Visual term=reverse cterm=reverse guibg=Grey
endif


" Screen font for gui mode
if has("gui_running")
    set lines=40		                 " Window height in lines.
    set columns=85	                     " Window width in characters.
    colorscheme joe                      " Changed 2011-03-04
    set guifont=Liberation\ Mono\ 16     " Changed 2015-10-11
    set cursorline      " Highlight current line background
                        " (cursorcolumn also available)
else
    " No GUI running
    colorscheme desert      " Added 2012-02-01
    set nospell             " Added 2012-02-01
    set nocursorline        " Do not highlight current line background
endif

" Colorcolumn only works with Vim 7.3 or higher
set colorcolumn=+1,+2,+3

" ==========================================================================
" Key maps
" ==========================================================================
" Normal mode
" -----------
" Toggle taglist upon pressing F8 in normal mode.
" (http://vim-taglist.sourceforge.net)
nnoremap <silent> <F8> :TlistToggle<CR>
" Shift-F8 to update tags
nnoremap <S-F8> :TlistUpdate<CR>

" Map CRTL-S to save like a Windows program
" From mswin.vim implementation 2011-09-14
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Go to Internet
nnoremap <Leader>i :exec "!start explorer " . expand("<cWORD>")<cr>

" Select current paragraph and sort it
" Mnemonic: \a = sort a to z
nnoremap <Leader>a vip:sort<CR>

" Open Windows explorer at current buffer
" http://vim.wikia.com/wiki/Open_Windows_Explorer_showing_directory_of_current_buffer
if has("win32") " Under Windows only of course
    nnoremap <Leader>e :!start explorer /select,%:p<cr>
endif

" Open line below current line with ,o. 
nnoremap <Leader>o o<esc>k
" Open line above current line with ,O.
nnoremap <Leader>O O<esc>j

" Toggle highlighting on or off using F4
map <F4> :set nohls!<CR>:set nohls?<CR>

" Reload legnerjm.vim using ,s keystrokes in normal mode.
nnoremap <Leader>s :source $MYVIMRC<CR>

" Make session using ,ms
nnoremap <Leader>ms :mksession! $legnerjm/sessions/
" Source session using ,ss
nnoremap <Leader>ss :wa<CR>:source $legnerjm/sessions/

" Insert mode
" -----------
" Insert ISO 6801 date in insert mode by pressing <CTRL-D>
inoremap <C-D> <C-R>=strftime("%Y-%m-%d")<CR>

" Visual mode
" -----------
" Retain visual block after left shift (gv = reselect block). 
vnoremap < <gv 
" Retain visual block after right shift (gv = reselect block).
vnoremap > >gv  
" CTRL-C copies like Windows. "+ indicates clipboard register, p is paste.
" vnoremap <C-C> "+y
" CTRL-V pastes like Windows. "+ indicates clipboard register, p is paste.
"vnoremap <C-V> "+p
" Use CTRL-Q to do what CTRL-V used to do, visual column mode.
"noremap <C-Q> <C-V>

" ==========================================================================
" Insert mode abbreviations
" ==========================================================================
" These insert mode abbreviations are for all file types.
iabbr teh the 

" ==========================================================================
" File type specific settings
" ==========================================================================
" When you enter (or exit) a file of a specific file type, Vim will load the
" settings from a specified file.

" -------------------------------------
" Python (*.py)
" -------------------------------------
" Import vim configuration upon opening a .py file.
autocmd BufEnter *.py source ~/.vim/pyedit.vim
" Load Python-specific menu.
autocmd BufEnter *.py source ~/.vim/scripts/python.vim
" Turn on omni completion for python.
"autocmd FileType python set omnifunc=pythoncomplete#Complete
" Highlight end of line whitespace
autocmd FileType python highlight WhitespaceEOL ctermbg=red guibg=red
autocmd FileType python match WhitespaceEOL /\s\+$/
" Wrap comments
" Read a template file for python upon creation of a new .py file.
autocmd BufNewFile *.py 0r $legnerjm/new.py
" Wrap only comments
"autocmd FileType python set formatoptions=croql
autocmd FileType python set linebreak
autocmd FileType python set nowrap

" -------------------------------------
" HTML/XML (*.html, *.xml, *.xsl)
" -------------------------------------
" Load a script which allows you to press CTRL+_ to close an HTML tag.
autocmd Filetype html,xml,xsl source $legnerjm\scripts\closetag.vim
autocmd BufEnter *.html set nowrap

" -------------------------------------
" Cascading style sheets (*.css)
" -------------------------------------
" Wrap text for standard text files.
autocmd BufEnter *.css set nowrap

" -------------------------------------
" LaTeX (*.tex)
" -------------------------------------
" Wrap text for LaTeX files.
autocmd Filetype tex set textwidth=0
autocmd Filetype tex set wrap
autocmd Filetype tex set linebreak
autocmd Filetype tex set nofoldenable

" -------------------------------------
" Text (*.txt)
" -------------------------------------
" Wrap text for standard text files.
autocmd BufRead *.txt set textwidth=80
autocmd BufRead *.txt set wrap
autocmd BufRead *.txt set linebreak

" -------------------------------------
" Restructured Text (*.rst)
" -------------------------------------
" Press \= on a line to underline it with a line of = signs
" Press \- on a line to underline it with a line of -
autocmd BufRead *.rst nnoremap <Leader>- YpVr-
autocmd BufRead *.rst nnoremap <Leader>= YpVr=
" Press \+ on a line to put line of **** above and below
autocmd BufRead *.rst nnoremap <Leader>+ YVr*ppVr*
autocmd BufRead *.rst set linebreak
autocmd BufRead *.rst set shiftwidth=3	
autocmd BufRead *.rst set softtabstop=3
autocmd BufRead *.rst set tabstop=3
autocmd BufRead *.rst set textwidth=0
autocmd BufRead *.rst set wrap

" -------------------------------------
" VIM source files (*.vim)
" -------------------------------------
autocmd BufRead *.vim set nowrap

" ------------------------------------------
" Vim Outliner files (*.otl)
" ------------------------------------------
autocmd BufRead *.otl set printoptions=number:y " print line numbers
autocmd BufReadPost *.otl set foldlevel=0

" ------------------------------------------
" Getting Things Done list (*.gtd)
" ------------------------------------------
autocmd BufRead *.gtd set printoptions=number:y " print line numbers
autocmd BufReadPost *.gtd hi def link waitTodo Todo
autocmd BufReadPost *.gtd match waitTodo /\<WAIT\>/
autocmd BufReadPost *.gtd set filetype=vo_base.gtd
autocmd BufReadPost *.gtd set foldlevel=0
" Highlight columns to right of 72 so they don't wrap when printed
autocmd BufReadPost *.gtd 2match DiffAdd /\%>78v.*/
" \t appends highlighted text to todo/todo.txt
autocmd BufReadPost *.gtd vnoremap <Leader>t :<c-u>silent! '<,'> w! >> todo/todo.txt<CR>
" Create a Vimoutliner check box
autocmd BufReadPost *.gtd map <Leader>b ,,cbj
" Toggle state of a Vimoutliner check box
autocmd BufReadPost *.gtd map <Leader>x ,,cxj

" ------------------------------------------
" todo.txt
" ------------------------------------------
autocmd BufReadPost todo.txt set filetype=todotxt
" autocmd BufWritePre todo.txt :sort

" Delete trailing whitespace when saving
autocmd FileType c,cpp,php,python autocmd BufWritePre <buffer> :%s/\s\+$//e

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    set guifont=Menlo\ Regular:h14
  endif
endif

