if exists("b:did_pyproject_plugin")
    finish 
else
    let b:did_pyproject_plugin = 1
endif

if !exists("g:pyproject_path")

python << EOF
"""Created 2011-06-17 by JML"""
import vim
import os

def parent_path(current_path):
    """Returns path for parent directory.  If passed L:\projects\joe
    it will return L:\projects"""
    return os.path.split(current_path)[0]

def find_project_path():
    """Returns project directory path as a string.  We will do this by
    looking for a directory containing both manage.py and settings.py"""
    retval = None
    current_path = os.getcwd()
    while retval is None:
        files = os.listdir(current_path)
        if "settings.py" in files and "manage.py" in files:
            retval = current_path
        else:
            last_path = current_path
            current_path = parent_path(current_path)
            if last_path == current_path:
                # This file is apparently not in a Django project
                retval = ""
    if len(retval):
        vim.command(r"cabbr pyproject_path %s" % retval)
        vim.command(r"cd %s" % retval)
    return retval

find_project_path()
EOF
endif
