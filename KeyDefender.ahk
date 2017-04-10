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



/*


;=============================================================
; Alphabet re-write
; This is required if choosing the "immunize" use case
; WARNING: This will cause considerable lag with real Time
; applications such as games, but appears to work fine in
; standard desktop applications
;=============================================================
*a::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +a
		}
		Else {
			Send, a
		}
	}
	Else {
		Send, {Blind}a
	}
Return

*b::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			SendInput, +b
		}
		Else {
			Send, b
		}
	}
	Else {
		Send, {Blind}b
	}
Return

*c::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +c
		}
		Else {
			Send, c
		}
	}
	Else {
		Send, {Blind}c
	}
Return

*d::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +d
		}
		Else {
			Send, d
		}
	}
	Else {
		Send, {Blind}d
	}
Return

*e::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +e
		}
		Else {
			Send, e
		}
	}
	Else {
		Send, {Blind}e
	}
Return

*f::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +f
		}
		Else {
			Send, f
		}
	}
	Else {
		Send, {Blind}f
	}
Return

*g::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +g
		}
		Else {
			Send, g
		}
	}
	Else {
		Send, {Blind}g
	}
Return

*h::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +h
		}
		Else {
			Send, h
		}
	}
	Else {
		Send, {Blind}h
	}
Return

*i::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +i
		}
		Else {
			Send, i
		}
	}
	Else {
		Send, {Blind}i
	}
Return

*j::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +j
		}
		Else {
			Send, j
		}
	}
	Else {
		Send, {Blind}j
	}
Return

*k::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +k
		}
		Else {
			Send, k
		}
	}
	Else {
		Send, {Blind}k
	}
Return

*l::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +l
		}
		Else {
			Send, l
		}
	}
	Else {
		Send, {Blind}l
	}
Return

*m::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +m
		}
		Else {
			Send, m
		}
	}
	Else {
		Send, {Blind}m
	}
Return

*n::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +n
		}
		Else {
			Send, n
		}
	}
	Else {
		Send, {Blind}n
	}
Return

*o::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +o
		}
		Else {
			Send, o
		}
	}
	Else {
		Send, {Blind}o
	}
Return

*p::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +p
		}
		Else {
			Send, p
		}
	}
	Else {
		Send, {Blind}p
	}
Return

*q::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +q
		}
		Else {
			Send, q
		}
	}
	Else {
		Send, {Blind}q
	}
Return

*r::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +r
		}
		Else {
			Send, r
		}
	}
	Else {
		Send, {Blind}r
	}
Return

*s::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +s
		}
		Else {
			Send, s
		}
	}
	Else {
		Send, {Blind}s
	}
Return

*t::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +t
		}
		Else {
			Send, t
		}
	}
	Else {
		Send, {Blind}t
	}
Return

*u::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +u
		}
		Else {
			Send, u
		}
	}
	Else {
		Send, {Blind}u
	}
Return

*v::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +v
		}
		Else {
			Send, v
		}
	}
	Else {
		Send, {Blind}v
	}
Return

*w::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +w
		}
		Else {
			Send, w
		}
	}
	Else {
		Send, {Blind}w
	}
Return

*x::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +x
		}
		Else {
			Send, x
		}
	}
	Else {
		Send, {Blind}x
	}
Return

*y::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +y
		}
		Else {
			Send, y
		}
	}
	Else {
		Send, {Blind}y
	}
Return

*z::
	if (GetKeyState("CapsLock", "T") = 1 AND clock = 1) {
		if GetKeyState("Shift") {
			Send, +z
		}
		Else {
			Send, z
		}
	}
	Else {
		Send, {Blind}z
	}
Return

*/