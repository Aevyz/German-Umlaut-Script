;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                   ;;
;; German Umlaut Script                              ;;
;; Based off of Ck's original script                 ;;
;;                                                   ;;
;; version: 160807                                   ;;
;;                                                   ;;
;; Contact: https://github.com/AetherV               ;;
;;                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Original Thread:           https://autohotkey.com/board/topic/515-german-umlaute-convenience-script/
;; Current Github Page:       https://github.com/AetherV/German-Umlaut-Script


;; Usage Instructions:
;; -------------------
;; Load Script into AutoHotKey
;; a) Press any of the TRIGGERKEYS [u,U,a,A,o,O,s,"] in any application of your choice
;; b) Within DELAY seconds, press the UMLAUTKEY to morph it into [ü,Ü,ä,Ä,ö,Ö,ß,„]

; after pressing a TRIGGERKEY, you have to wait DELAY seconds to press the UMLAUTKEY
; and make it appear normally (without triggering any Umlaut morphing)
DELAY = 1.0 ; default = 1
UMLAUTKEY = 1 ; default = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; You shouldn't have to edit below this line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;#NoTrayIcon 

; remember the latest activated Umlaut
UMLAUT = x

$u::
; Above: Use the $ to force the hook to be used, which prevents an
; infinite loop since this subroutine itself sends Numpad0, which
; would otherwise result in a recursive call to itself.
; mirror self
Send, u
; initialize current Umlaut
UMLAUT = ü
Goto, WaitForUK

$+u::
Send, U
UMLAUT = Ü
Goto, WaitForUK

$o::
Send, o
UMLAUT = ö
Goto, WaitForUK

$+o::
Send, O
UMLAUT = Ö
Goto, WaitForUK

$a::
Send, a
UMLAUT = ä
Goto, WaitForUK

$+a::
Send, A
UMLAUT = Ä
Goto, WaitForUK

$"::
Send, "
UMLAUT = „
Goto, WaitForUK

$s::
Send, s
UMLAUT = ß



WaitForUK:
; disable this and every other TRIGGERKEY to speed things up
Hotkey, $u, Off
Hotkey, $+u, Off
Hotkey, $o, Off
Hotkey, $+o, Off
Hotkey, $a, Off
Hotkey, $+a, Off
Hotkey, $s, Off
Hotkey, $", Off

; Most editors can handle the fastest speed (-1)
SetKeyDelay, 0 ; 0 for reliability

; repeat until EITHER the UMLAUTKEY was hit or any other key breaking the sequence (non TRIGGERKEY)
Loop
{
	; watch next input string (only wait for exactly one char, mirror input, ignore backspace and wait DELAY seconds)
	Input, UserInput, V L1 B T%DELAY%
	if UserInput = %UMLAUTKEY% 
	{
	 	Send, {backspace 2}%UMLAUT%
	 	break
        } 
        else if UserInput = u
		UMLAUT = ü
	else if UserInput = o
		UMLAUT = ö
	else if UserInput = +o
		UMLAUT = Ö
	else if UserInput = a
		UMLAUT = ä
	else if UserInput = A
		UMLAUT = Ä
	else if UserInput = s
		UMLAUT = ß
	else if UserInput = "
		UMLAUT = „
	else 
		break
}

; re-enable all initial Umlaut TRIGGERKEYS
Hotkey, $u, On
Hotkey, $+u, On
Hotkey, $o, On
Hotkey, $+o, On
Hotkey, $a, On
Hotkey, $+a, On
Hotkey, $s, On
Hotkey, $", On

; finish this hotkey handling routine	
return
