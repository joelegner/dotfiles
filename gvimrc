" 2021-06-26 Joe Legner
" 2022-08-21 Joe Legner

" ==========================================================================
" Compatibility
" ==========================================================================
set noignorecase    " Do not ignore case when searching.
set backspace=indent,eol,start  " Delete indents, end of lines and starts
setlocal spell spelllang=en_us

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
set formatoptions=l " 2021-01-10 Word break
set lbr             " 2021-01-10 Word break
set tabstop=4		" Width of a tab in characters.
set wildmenu        " Turn on wild menu
set wildmode=full
set wrap		    " Wrap long lines of text
syntax on           " Turn on syntax highlighting.
colorscheme desert  " Changed this 2022-08-21 for fun.

" Font for GUI
if has("gui_running")
    set lines=35		                 " Window height in lines.
    set columns=80	                     " Window width in characters.
    set guifont=Inconsolata\ for\ Powerline:h22
endif

" Toggle highlighting on or off using F4
map <F4> :set nohls!<CR>:set nohls?<CR>

" Insert mode
" -----------
" Insert ISO 6801 date in insert mode by pressing <CTRL-D>
inoremap <D-d> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <D-D> <C-R>=strftime("%B %-d, %Y")<CR>

" Visual mode
" -----------
" Retain visual block after left shift (gv = reselect block). 
vnoremap < <gv 
" Retain visual block after right shift (gv = reselect block).
vnoremap > >gv  
"
" -------------------------------------
" Python (*.py)
" -------------------------------------
autocmd FileType python set linebreak
autocmd FileType python set nowrap
"
"
" -------------------------------------
" LaTeX (*.tex)
" -------------------------------------
" Wrap text for LaTeX files.
autocmd Filetype tex set textwidth=0
autocmd Filetype tex set wrap
autocmd Filetype tex set linebreak
autocmd Filetype tex set nofoldenable
"
" -------------------------------------
" Text (*.txt)
" -------------------------------------
" Wrap text for standard text files.
autocmd Filetype txt set textwidth=80
autocmd Filetype txt set wrap
autocmd Filetype txt set linebreak
"
" -------------------------------------
" VIM source files (*.vim)
" -------------------------------------
autocmd BufRead *.vim set nowrap

