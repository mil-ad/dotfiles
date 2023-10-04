on run argv
	set temp to the clipboard
	set the clipboard to item 1 of argv
	tell application "System Events"
		keystroke "v" using command down
	end tell
	delay 4
	set the clipboard to temp
end run
