; startup-common.ahk
; Common parts of AutoHotkey startup script 
; Add to computer-specific startup scripts:
;
; #include startup-common.ahk 

; =============================================================================
; Docs
; =============================================================================
; Special characters:
; # = Windows key
; ^ = Control key
; ! = Alt key
; + = Shift key
;
; Therefore:
; ^!c = Ctrl-Alt-C

; Commands:
; Run PROGRAM|DOCUMENT|URL|SHORTCUT
; RunWait PROGRAM|DOCUMENT|URL|SHORTCUT
; MsgBox MESSAGE
; Send KEYSTROKES


; =============================================================================
; SpeedCrunch CTRL-ALT-C (C = "Calculator")
; =============================================================================
^!c::Run %DROPBOX%\Apps\Engineering\SpeedCrunch-0.10.1\speedcrunch.exe

; =============================================================================
; Explore My Documents CTRL-ALT-E
; =============================================================================
^!e::Run %MY_DOCUMENTS%

; =============================================================================
; FreeFileSyncPortable CTRL-ALT-F
; =============================================================================
^!f::Run %DROPBOX%\Apps\System\FreeFileSyncPortable\FreeFileSyncPortable.exe

; =============================================================================
; Explore Dropbox
; =============================================================================
^!d::Run %DROPBOX%

; =============================================================================
; Journal CTRL-ALT-J
; =============================================================================
^!j::Run %DROPBOX%\References\Journal\journal.rst

; =============================================================================
; Wunderlist
; =============================================================================
^!w::Run http://www.wunderlist.com/webapp/

; =============================================================================
; Launch KB index.html CTRL-ALT-K
; =============================================================================
^!k::Run %DROPBOX%\kb\build\html\index.html

; =============================================================================
; Start Cygwin terminal CTRL-ALT-T
; =============================================================================
^!t::Run C:\cygwin\bin\mintty.exe -i /Cygwin-Terminal.ico -

; =============================================================================
; Vim CTRL-ALT-V
; =============================================================================
^!v::Run %VIM%

; =============================================================================
; Start todo.txt with CTRL-SPACE
; =============================================================================
^space::Run %DROPBOX%\gtd\todo\todo.txt

; =============================================================================
; Search Google from any app by Ctrl-Shift-C
; =============================================================================
^+c::
{
    Send, ^c
    Sleep 50
    Run, http://www.google.com/search?q=%clipboard%
    Return
}

; =============================================================================
; Example of sending keystrokes
; =============================================================================
; ^!s::
; Send Sincerely,{Enter}Joe Legner, P.E.
; return

; =============================================================================
; Hotstrings 
; =============================================================================
; Replace btw with "by the way":
; ::btw::by the way

; =============================================================================
; Stuff to do when Windows Explorer is open
; =============================================================================
#IfWinActive ahk_class ExploreWClass|CabinetWClass
    ; -------------------------------------------------------------------------
    ; create new folder
    ; -------------------------------------------------------------------------
    ^!n::Send !fwf

    ; -------------------------------------------------------------------------
    ; open 'cmd' prompt in the current directory
    ; -------------------------------------------------------------------------
    ^!p::
        OpenCmdInCurrent()
    return
#IfWinActive

; =============================================================================
; Opens the command shell 'cmd' in the directory browsed in Explorer.
; Note: expecting to be run when the active window is Explorer.
; =============================================================================
OpenCmdInCurrent()
{
    WinGetText, full_path, A    ; This is required to get the full path of the
                                ; file from the address bar

    ; Split on newline (`n)
    StringSplit, word_array, full_path, `n
    full_path = %word_array1%   ; Take the first element from the array

    ; Just in case - remove all carriage returns (`r)
    StringReplace, full_path, full_path, `r, , all  
    full_path := RegExReplace(full_path, "^Address: ", "") ;

    IfInString full_path, \
    {
        Run, cmd /K cd /D "%full_path%"
    }
    else
    {
        Run, cmd /K cd /D "C:\ "
    }
}

; =============================================================================
; Stuff to do when LibreOffice Draw is open
; =============================================================================
#IfWinActive ahk_class SALFRAME
    ; -------------------------------------------------------------------------
    ; Insert math multiplication symbol (dot)
    ; -------------------------------------------------------------------------
    ^*::Send ·

    ^NumpadMult::Send ·
#IfWinActive
