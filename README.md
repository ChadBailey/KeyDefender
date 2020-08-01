# KeyDefender
Block accidental keypresses that interrupt gaming

KeyDefender was originally created for my wife to prevent her from going into 
ALL CAPS RAGE when she accidentally hit the windows key taking her out of her 
game. Since then, it expanded to include more features as I've found the need. 
Now it has become a bit more of a "gaming buddy" than its original purpose. 
Here is a complete list of the current capabilities.

# Abilities

## Usage Notes

> NOTE: The resolution toggles were built to be used to assist changing 
> the resolution via remote access which can be problematic at best. 
> i.e. Shadow.tech, Parsec, Moonlight-Stream, QEMU, etc.
> 
> This is why they intentionally bypass all confirmation dialogs (since 
> often times you can't get logged back in in time to press the confirm 
> dialog)

## Table

| Hotkey            | Function            | Default   | Notes/Description                                   |
| ---               | ---                 | ---       | ---                                                 |
| `CTRL+F12`        | Borderles Fullscreen| N/A       | Toggles borderless fullscreen in any active application.<br>**NOTE: Does not work well with some window types. Intended for use with games. Works with nearly every game tested, even some which are known to not work with other borderless fullscreen software. |
| `CTRL+ALT+Q`      | Quick Swap Monitor  | N/A       | Quickly swaps active application from one monitor<br>to the next.<br>**NOTE: This was built in order to fix poorly coded<br>programs from appearing on a display that's no <br>longer connected. Alternately, it can be helpful <br>when using remote access software that does not <br>support multiple displays. There are strange hard <br>coded values for monitor sizes, but in my testing <br>this works for any resolution. I can not recall why <br>the hard coded values but I've left them alone<br>since it works.** |
| Right-click Menu  | Disable Capslock    | On        | Toggles capslock off as soon as the key is released<br>**NOTE: *Does not* prevent keymapping** |
| Right-click Menu  | Disable Left WinKey | Off       | Prevents left Windows key from opening windows menu<br>**NOTE1: *Does not* prevent keymapping**<br>**NOTE2: *Does not* block windows key combinations<br>so for exanple Win + L will still lock your PC** |
| Right-click Menu  | Disable Alt-Tab     | Off       | Prevents alt-tab menu from appearing.<br>**NOTE: *Does not* prevent keymapping**|
| Right-click Menu  | Disable Insert      | Off       | Prevents insert from toggling insert (causes your<br>keystrokes to overwrite existing text if your<br>cursor is not at the end of the line)<br>**NOTE: *Does* prevent keymapping**|
| Right-click Menu  | Disable F1          | Off       | Disables F1<br>**NOTE: *Does* prevent keymapping**  |
| Right-click Menu  | Resolution > 4k     | N/A       | Instantly sets resolution to 3840x2160<br>**CAUTION: USE WITH CARE. BYPASSES WINDOWS CONFIRM/REVERT DIALOG**|
| Right-click Menu  | Resolution > 1080p  | N/A       | Instantly sets resolution to 1920x1080<br>**CAUTION: USE WITH CARE. BYPASSES WINDOWS CONFIRM/REVERT DIALOG**|
| Right-click Menu  | Resolution > 720p   | N/A       | Instantly sets resolution to 1280x720<br>**CAUTION: USE WITH CARE. BYPASSES WINDOWS CONFIRM/REVERT DIALOG**|
| Right-click Menu  | Resolution > Kindle | N/A       | Instantly sets resolution to 1366x768<br>**CAUTION: USE WITH CARE. BYPASSES WINDOWS CONFIRM/REVERT DIALOG**|
| Right-click Menu  | Swap Monitor (CTRL+Alt+Q) | N/A       | Does not do anything (Only provided to remind user<br>what the hotkey combination is)|




# Contributing

I would love to add features to this but this isn't exactly on the top of 
priorities. If you would like to contribute, please do! Here is a list of 
things I hope to one day implement

## Feature Backlog
 - Fix hard coding of monitor hz within resolution swap (ideally, maintain
   existing refresh rate and maybe even add a refresh rate swapper)
 - Remove quick-swap monitor hard coding, and extend to support n number
   of monitors (each keypress should just advance to next monitor)
 - Confirm dialog on resolution toggle
 - Ability to save settings
 - Ability to configure hotkeys
 - More resolutions/configurable resolutions
 - Ability to allow caps lock to stay on, but not come out as caps when
   typing
     > You can see my progress on this by looking at any code that 
     > refers to "immunize" - I never got it working to my satisfaction
- Ability to toggle features based upon active game
- Ability to externally remap keys for games that don't support keybinding
  remapping (older games, usually)
- Ability to change power profiles, particularly if tied to the ability to 
   sense which (if any) external display is connected
 - A Linux/Mac version would be cool, but due to the nature of this being 
   strictly API based that would require every feature be completely 
   rewritten for each supported platform.

