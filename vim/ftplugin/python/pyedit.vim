" *.py filetype specific vimrc file.
" This file is loaded by autocommand when a Python file is read into a buffer
" in accordance with legnerjm.vim.
"
" 2008-01-19 by JML


" =============================================================================
" Functions
" =============================================================================
" Call pydoc for the word under the cursor.  Since it only works in Linux, we
" must only define it in a Linux environment.
if !has("win32")
    function! ShowDoc(name)
      enew
      execute "read !pydoc " . a:name
      setlocal nomodifiable
      setlocal nomodified
      set filetype=man
      normal 1G
    endfunction
    map <buffer> <silent> <F2> :call ShowDoc("<C-R><C-W>")<CR>
endif


" =============================================================================
" Abbreviations
" =============================================================================
iabbr Def def

" =============================================================================
" Key maps
" =============================================================================
" All modes
" ---------
" Run python on the current file, designated %. Modifier :p gives full path.
map <F5> <esc>:!python %:p<cr><cr>

" Normal mode
" -----------
" Insert a double line 80 characters wide to delimit parts of a Python file.
nmap <M-=> o# =============================================================================<cr># 
" Join line with next and add a line break at the last comma before col. 80.
nmap ,j J,g
" Add a line break right after the last comma before column 80 in the line.
nmap ,g 080lF,a<cr><ESC>

" Insert mode
" -----------

" Visual mode
" -----------

" =============================================================================
" Python Path 
" =============================================================================
" Add all non-trivial Python paths to the Vim paths.
" Reference http://vim.wikia.com/wiki/Automatically_add_Python_paths_to_Vim_path
python << EOF
import os
import sys
import vim
for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Set the window title
set title
python << EOF
import os
no_ext_path = os.path.splitext(vim.current.buffer.name)[0]
head1, tail1 = os.path.split(no_ext_path)
head2, tail2 = os.path.split(head1)
is_bearclaw = (vim.current.buffer.name.lower().find('bearclaw') != -1)
short_title = os.path.join(tail2, tail1)
if is_bearclaw:
    title = r"%s" % (short_title)
else:
    title = r"%s (%s)" % (short_title, vim.current.buffer.name)
vim.command("let &titlestring = escape('%s', '\')" % title)
EOF
