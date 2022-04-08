#@osa-lang:AppleScript
-- I have to quit iTunes because I need to remove a mounted volume that holds music.
-- If iTunes is open the volume won't umount as it is in use.
--
--
if application "Music" is running then
	tell application "Music" to quit
end if

if application "Microsoft PowerPoint" is running then
	tell application "Microsoft PowerPoint" to quit
end if

if application "Microsoft Word" is running then
	tell application "Microsoft Word" to quit
end if

if application "Microsoft Excel" is running then
	tell application "Microsoft Excel" to quit
end if

if application "Microsoft PowerPoint" is running then
	tell application "Microsoft PowerPoint" to quit
end if

if application "Microsoft Word" is running then
	tell application "Microsoft Word" to quit
end if

if application "Microsoft OneNote" is running then
	tell application "Microsoft OneNote" to quit
end if

if application "Keeper Password Manager" is running then
	tell application "Keeper Password Manager" to quit
end if

if application "Preview" is running then
	tell application "Preview" to quit
end if

if application "Script Editor" is running then
	tell application "Script Editor" to quit
end if


tell application "System Events"
	tell process "ControlCenter"

		set BluetoothButton to menu bar item "Bluetooth" of menu bar 1
		click BluetoothButton

		delay 1

		--return entire contents of front window

		set OnSwitch to checkbox "Bluetooth" of group 1 of window "Control Center"
		if value of OnSwitch is 0 then
			click OnSwitch
			delay 2
		end if

		set TheCheckbox to checkbox "Belkin G22" of scroll area 1 of group 1 of window "Control Center"

		if value of TheCheckbox is 1 then click TheCheckbox
		click BluetoothButton
	end tell
end tell

--
--umount all removable disks with the expection of my SD Card which stays in all the time
--
tell application "Finder" to eject (every disk whose ejectable is true and name does not contain "Box")
--tell application "Finder" to eject (every disk whose ejectable is true)
--
--or you can call a specific drive like this
--tell application "Finder" to eject (every disk whose name is "MobileMusic")
-- put the Mac to sleep
tell application "System Events"
	sleep
end tell
--
