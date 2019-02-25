; startup-cygin.ahk
; AutoHotkey startup script for work "dostrofsky" computer
; =============================================================================
; Settings
; =============================================================================
SetTitleMatchMode RegEx ;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey
        ; releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and
                ; reliability.

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

DROPBOX=C:\Documents and Settings\jlegner\My Documents\Dropbox
MY_DOCUMENTS=C:\Documents and Settings\jlegner\My Documents
VIM=C:\Program Files\Vim\vim73\gvim.exe

#include startup-common.ahk
