; startup-legner5.ahk
; AutoHotkey startup script for legner5 computer
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

DROPBOX=E:\Dropbox
MY_DOCUMENTS=C:\Users\Joe\Documents
VIM=C:\Program Files (x86)\Vim\vim73\gvim.exe

#include startup-common.ahk

