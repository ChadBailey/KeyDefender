#Persistent
#SingleInstance
;#UseHook ; Would prefer not to use

Menu, Tray, NoStandard ; remove standard Menu items
Menu, Tray, Add, Disable &CapsLock, Disable_Capslock
Menu, Tray, Add, Disable Left &Winkey, Disable_LWin
Menu, Tray, Add, Disable &Alt-Tab, Disable_AltTab
Menu, Tray, Add, Disable &Insert, Disable_Insert
Menu, Tray, Add, Disable &F1, Disable_F1
Menu, Tray, Add, E&xit, ButtonExit ;add a item named Exit that goes to the ButtonExit label

SendMode InputThenPlay ; Try input first, if unavailable fall back to play. Input mode is fastest

initialize:
	menu, tray, ToggleCheck, Disable &CapsLock
	clock := 1

	menu, tray, ToggleCheck, Disable Left &Winkey
	lwin := 1

	menu, tray, ToggleCheck, Disable &Alt-Tab
	alttab := 1

Return

; Non-Immunize version. Works fine, but doesn't allow you to utilize the toggle-state of capslock.

*Capslock::
	if (clock = 1) {
		;Alternate method, capslock light always stays off, but does not allow capslock down event to fire
		;SetCapsLockState, AlwaysOff

		;Best method, turns caps lock off as soon as the user lets go
		Send,{Capslock}
		While GetKeyState("Capslock","P") ; While loop prevents "thrashing" of key/light/state
			Sleep 5 ; optimization to reduce cpu usage - possibly too aggressive
		keywait, Capslock
		SetCapslockState, Off
	}
	;Emulate default functionality of capslock
	;(why can't autohotkey have a way to just use default behavior? maybe I just haven't found it)
	Else {
		if GetKeyState("CapsLock", "T") = 1 {
		   SetCapsLockState, off
		 }
		else if GetKeyState("CapsLock", "F") = 0 {
		   SetCapsLockState, on
		 }
 	}
return

~LWin Up::
	if (lwin = 1) {
		Return
	}
	Else {
		Send, {LWin}
	}
Return

!Tab::
	if (alttab = 1) {
		Return
	}
	Else {
		Send, {AltDown}{Tab}
	}
Return

$Insert::
	if (insert = 1) {
		Return
	}
	Else {
		Send, {Insert}
	}
return

$F1::
	if (F1 = 1) {
		Return
	}
	Else {
		Send, {F1}
	}
return


Disable_Capslock:
	menu, tray, ToggleCheck, Immunize &CapsLock
	clock := !clock ; toggle
Return

Disable_LWin:
	menu, tray, ToggleCheck, Disable Left &Winkey
	lwin := !lwin ; toggle
Return

Disable_AltTab:
	menu, tray, ToggleCheck, Disable &Alt-Tab
	alttab := !alttab ; toggle
Return

Disable_Insert:
	menu, tray, ToggleCheck, Disable &Insert
	insert := !insert ; toggle
Return

Disable_F1:
	menu, tray, ToggleCheck, Disable &F1
	F1 := !F1 ; toggle
Return

ButtonExit:
	ExitApp
Return ; redundant but my OCD insisted



