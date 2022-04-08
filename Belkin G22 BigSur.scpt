#@osa-lang:AppleScript
-- activate application "SystemUIServer"
set deviceName to "Belkin G22"
set bluetoothMenu to ""

tell application "System Events"
	tell its application process "ControlCenter"
		set menuBarItems to menu bar items of menu bar 1
		repeat with mbi in menuBarItems
			if name of mbi contains "Bluetooth" then
				set bluetoothMenu to mbi
			end if
		end repeat

		if bluetoothMenu is not equal to "" then
			click bluetoothMenu
			set deviceToggle to checkbox 1 of scroll area 1 of group 1 of window "Control Center" whose title contains deviceName

			-- Click the device.
			click deviceToggle

			set bluetoothMenu to (first menu bar item whose name contains "Bluetooth") of menu bar 1
			click bluetoothMenu

		else
			-- If the Display menu isn't in the menu bar, display an error message.
			set errorMessage to "Bluetooth menu not found in menu bar. Open System Preferences > Dock & Menu Bar. Set Display to \"Show in Menu Bar > Always.\""
			display dialog errorMessage with icon caution
		end if
	end tell
end tell

-- mute the volume when disconnecting audio or unmute
on setVolume(muted)
	if muted is "mute" then
		--	set curVolume to get volume settings
		--if	output muted of curVolume is false then
		set volume with output muted
	else
		--if muted is "unmute"
		set volume without output muted
	end if
end setVolume

