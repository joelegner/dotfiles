#!/usr/bin/bash

export GOOGLEONE=/media/family/GoogleOne
export EDITOR=vi
export PYTHONPATH=$PYTHONPATH:/media/family/GoogleOne/Tools
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.files/scripts
export PS1="[\u \W]\$ " # Use Webfaction's prompt
# Set the time zone
export TZ="/usr/share/zoneinfo/US/Eastern"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Default command aliases - may be overridden later
# 2018-04-28 Doesn't work
alias shred='shred -v -u'
alias kb='workon kb && cd $GOOGLEONE/References/kb'
alias dnf='sudo dnf'
alias docker='sudo docker'
# 2018-04-28 added -s switch to silence "No such file or directory" messages
alias fif="find . -type f | xargs fgrep -s"
alias fihtml="find . -type f -name '*.html' | xargs fgrep -s"
alias fipy="find . -type f -name '*.py' | xargs fgrep -s"
alias first="find . -type f -name '*.rst' | xargs fgrep -s"
alias fitxt="find . -type f -name '*.txt' | xargs fgrep -s"
alias g='cd $GOOGLEONE'
alias tree='tree --charset=ASCII'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # virtualenvwrapper settings
    # http://virtualenvwrapper.readthedocs.org/en/latest/
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/bin/python3
    source virtualenvwrapper.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set Python startup file
# See http://docs.python.org/2/using/cmdline.html#envvar-PYTHONSTARTUP
export PYTHONSTARTUP=~/.files/pythonstartup.py

