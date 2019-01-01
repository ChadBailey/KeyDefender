;;;;;;;;;;;;;;;;
; Declarations ;
;;;;;;;;;;;;;;;;

#Persistent
#SingleInstance force
;#UseHook ; Would prefer not to use

;;; Establish menu object structure

Menu, Tray, NoStandard ; remove standard Menu items
Menu, Tray, Add, Disable &CapsLock, Disable_Capslock
Menu, Tray, Add, Disable Left &Winkey, Disable_LWin
Menu, Tray, Add, Disable &Alt-Tab, Disable_AltTab
Menu, Tray, Add, Disable &Insert, Disable_Insert
Menu, Tray, Add, Disable &F1, Disable_F1

Menu, Tray, Add ; line separator

Menu, Resolutions, Add, 4k, Res_4k
Menu, Resolutions, Add, 1080p, Res_1080
Menu, Resolutions, Add, 720p, Res_720
Menu, Resolutions, Add, Kindle, Res_Kindle
Menu, Tray, Add, Resolution, :Resolutions

Menu, Tray, Add ; line separator
Menu, Tray, Add, Swap Monitor (Ctrl+Alt+Q), SwapWindowMonitor
Menu, Tray, Add, E&xit, ButtonExit ;add a item named Exit that goes to the ButtonExit label

;;; Set sendmode

SendMode InputThenPlay ; Try input first, if unavailable fall back to play. Input mode is fastest

;;;;;;;;;;;;;
; Menu/Tray ;
;;;;;;;;;;;;;

;;; Add menu objects to system tray

initialize:
  menu, tray, ToggleCheck, Disable &CapsLock
  clock := 1

  menu, tray, ToggleCheck, Disable Left &Winkey
  lwin := 1

  menu, tray, ToggleCheck, Disable &Alt-Tab
  alttab := 1

  UpdateResolutionCheckMark()
return

Disable_Capslock:
  menu, tray, ToggleCheck, Disable &CapsLock
  clock := !clock ; toggle
return

Disable_LWin:
  menu, tray, ToggleCheck, Disable Left &Winkey
  lwin := !lwin ; toggle
return

Disable_AltTab:
  menu, tray, ToggleCheck, Disable &Alt-Tab
  alttab := !alttab ; toggle
return

Disable_Insert:
  menu, tray, ToggleCheck, Disable &Insert
  insert := !insert ; toggle
return

Disable_F1:
  menu, tray, ToggleCheck, Disable &F1
  F1 := !F1 ; toggle
return

Res_4k:
  ChangeResolution(3840, 2160)
  UpdateResolutionCheckMark()
return

Res_1080:
  ChangeResolution(1920, 1080)
  UpdateResolutionCheckMark()
return

Res_720:
  ChangeResolution(1280, 720)
  UpdateResolutionCheckMark()
return

Res_Kindle:
  ChangeResolution(1366, 768)
  UpdateResolutionCheckMark()
return


ButtonExit:
  ExitApp
return ; redundant but my OCD insisted


;;;;;;;;;;;;;
; Functions ;
;;;;;;;;;;;;;

UpdateResolutionCheckMark() {
  res := GetMonitorResolution()

  if (res = "3840x2160") {
    menu, Resolutions, Check, 4K
  }
  else {
    menu, Resolutions, UnCheck, 4K
  }

  if (res = "1920x1080") {
    menu, Resolutions, Check, 1080p
  }
  else {
    menu, Resolutions, UnCheck, 1080p
  }

  if (res = "1280x720") {
    menu, Resolutions, Check, 720p
  }
  else {
    menu, Resolutions, UnCheck, 720p
  }

  if (res = "1366x768") {
    menu, Resolutions, Check, Kindle
  }
  else {
    menu, Resolutions, UnCheck, Kindle
  }
}


SwapWindowMonitor() {
  leftMonitorWidth = 1400
  leftMonitorHeight = 1050
  rightMonitorWidth = 1920
  rightMonitorHeight = 1200
  activeWindow := WinActive("A")

  if (activeWindow = 0) {
    return
  }
  WinGet, minMax, MinMax, ahk_id %activeWindow%
  if (minMax = 1) {
    WinRestore, ahk_id %activeWindow%
  }
  WinGetPos, x, y, width, height, ahk_id %activeWindow%
  if (x < 0) {
    xScale := rightMonitorWidth / leftMonitorWidth
    yScale := rightMonitorHeight / leftMonitorHeight
    x := leftMonitorWidth + x
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
  }
  else {
    xScale := leftMonitorWidth / rightMonitorWidth
    yScale := leftMonitorHeight / rightMonitorHeight
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
    newX := newX - leftMonitorWidth
  }
  WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
  if (minMax = 1) {
    WinMaximize, ahk_id %activeWindow%
  }
  WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
}

; Code taken (and adapted) from https://autohotkey.com/board/topic/114598-borderless-windowed-mode-forced-fullscreen-script-toggle/

ToggleFullscreen() {
  WinGetTitle, WinTit, A
  if (WinTit = "Shadow") {
    ToggleBorderlessFullscreen(-20,0)
  }
  else {
    ToggleBorderlessFullscreen(0,0)
  }
}

ToggleBorderlessFullscreen(ByRef offset_x, ByRef offset_y) {
  CoordMode Screen, Window
  static WINDOW_STYLE_UNDECORATED := -0xC40000
  static savedInfo := Object() ; Associative array
  WinGet, id, ID, A
  if (savedInfo[id]) {
    inf := savedInfo[id]
    WinSet, Style, % inf["style"], ahk_id %id%
    WinMove, ahk_id %id%,, % inf["x"], % inf["y"], % inf["width"], % inf["height"]
    savedInfo[id] := ""
  }
  else {
    savedInfo[id] := inf := Object()
    WinGet, ltmp, Style, A
    inf["style"] := ltmp
    WinGetPos, ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
    inf["x"] := ltmpX
    inf["y"] := ltmpY
    inf["width"] := ltmpWidth
    inf["height"] := ltmpHeight

    WinSet, Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
    mon := GetMonitorActiveWindow()
    ;DllCall("SetMenu", uint, WinExist(), uint, 0) ; Removes menu-bar
    SysGet, mon, Monitor, %mon%
    posx := monTop + offset_x
    posy := monLeft + offset_y
    WinMove, A,, %posy%, %posx%, % monRight-posy, % monBottom-posx
  }
}

GetMonitorAtPos(x,y) {
  ;; Monitor number at position x,y or -1 if x,y outside monitors.
  SysGet monitorCount, MonitorCount
  i := 0
  while(i < monitorCount) {
    SysGet area, Monitor, %i%
    if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom ) {
      return i
    }
    i := i+1
  }
  return -1
}

GetMonitorActiveWindow() {
  ;; Get Monitor number at the center position of the Active window.
  WinGetPos x,y,width,height, A
  return GetMonitorAtPos(x+width/2, y+height/2)
}

GetMonitorResolution() {
  SysGet, res, Monitor
  return resRight . "x" . resBottom
}

ChangeResolution(Screen_Width := 1920, Screen_Height := 1080, Color_Depth := 32, Hz:=0) {
	VarSetCapacity(Device_Mode,156,0)
	NumPut(156,Device_Mode,36)
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&Device_Mode )
	NumPut(0x5c0000,Device_Mode,40)
	NumPut(Color_Depth,Device_Mode,104)
	NumPut(Screen_Width,Device_Mode,108)
	NumPut(Screen_Height,Device_Mode,112)
  if (Hz > 0) {
    NumPut(Hz,Device_Mode,120)
  }
	return DllCall( "ChangeDisplaySettingsA", UInt,&Device_Mode, UInt,0 )
}

;;;;;;;;;;;;
; Keybinds ;
;;;;;;;;;;;;

;Ctrl+F12
^F12::ToggleFullscreen()
;Ctrl+Alt+Q
^!q::SwapWindowMonitor()

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
  else {
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
    return
  }
  else {
    Send, {LWin}
  }
return

!Tab::
  if (alttab = 1) {
    return
  }
  else {
    Send, {AltDown}{Tab}
  }
return

$Insert::
  if (insert = 1) {
    return
  }
  else {
    Send, {Insert}
  }
return

$F1::
  if (F1 = 1) {
    return
  }
  else {
    Send, {F1}
  }
return