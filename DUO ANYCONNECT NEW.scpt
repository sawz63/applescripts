#@osa-lang:AppleScript
(*
Script to automate the workflow of establishing a VPN session with AnyConnect, using Duo Multi-Factor Authentication and a Yubikey OTP device.
https://wwwin-github.cisco.com/jwallis/AnyConnect_Duo_Yubikey
*)
global userToken
set resetPassword to ""
set clearSettings to ""
(* prefsName is the variable for preference panes and keychain naming for user preferences and security
for example if set to TESTME the preference pane would be com.cisco.TESTME and the keychain entry
would be TESTME.<YOURUSERID> *)
global prefsName
global myPassword
set prefsName to "AnyConnectDuo"
(*
Walk a UI Element hierarchy rooted at ParentUIElem and return the first element whose role and description match
*)
on RecurseUIForElem(ParentUIElem, ElemRole, ElemDescription)
	tell application "System Events"
		set ResultElem to (UI elements of ParentUIElem whose role is ElemRole and (title is ElemDescription or description is ElemDescription))
		if ResultElem is not {} then
			return item 1 of ResultElem
		end if
		try
			repeat with UIElem in UI elements of ParentUIElem
				set ResultElem to my RecurseUIForElem(UIElem, ElemRole, ElemDescription)
				if ResultElem is not {} then
					return ResultElem
				end if
			end repeat
		on error errStr number errorNumber
			if the errorNumber is equal to -1719 then
				return {}
			else
				error errStr number errorNumber
			end if
		end try
	end tell
	return {}
end RecurseUIForElem


(*
Walk a UI Element hierarchy rooted at ParentUIElem and return the first element with an attribute with name AttrName and value AttrVal.  If AttrVal is "", then the match is just performed on AttrName
*)
on RecurseUIForAttribute(ParentUIElem, AttrName, AttrVal)
	tell application "System Events"
		repeat with ElemAttr in ((attributes of ParentUIElem) whose name is AttrName)
			if AttrVal is "" or AttrVal is value of ElemAttr then
				return ParentUIElem
			end if
		end repeat

		repeat with UIElem in UI elements of ParentUIElem
			set ResultElem to my RecurseUIForAttribute(UIElem, AttrName, AttrVal)
			if ResultElem is not {} then
				return ResultElem
			end if
		end repeat
	end tell
	return {}
end RecurseUIForAttribute


(*
Return the GenCount'th ancestor of UIElement. GenCount=1 => parent, GenCount=2 => grandparent, etc.
*)
on GetUIAncestor(UIElement, GenCount)
	tell application "System Events"
		repeat GenCount times
			set UIElement to value of attribute "AXParent" of UIElement
		end repeat
		return UIElement
	end tell
end GetUIAncestor

on KeyChainer(action)
	--display dialog action
	set returnValue to ""
	-- Use the "security" command instead of KeyChain Scripting (from Joe Hildebrand)
	-- set myPassword to do shell script "security 2>&1 >/dev/null find-generic-password -gl AnyConnectDuo | sed -n 's/^password: \"\\([^\"]*\\)\"/\\1/p'"
	set myPassword to do shell script "security 2>&1 >/dev/null find-generic-password -gl " & prefsName & " | sed -n 's/^password: \"\\([^\"]*\\)\"/\\1/p'"

	if (length of myPassword is 0) then
		my_Prefs("reset", "resetpwd")
		if action is "delete" then
			return ""
		end if


		-- Key not already on the KeyChain.    Prompt for it and add..
		activate
		set passwordq to display dialog ("What is the AnyConnect Password") default answer "" with title name of me with hidden answer
		set myPassword to text returned of passwordq
		try
			set b to do shell script "defaults read com.cisco." & prefsName & " saved"
			set b to "1"
		on error -- no previous setting
			set b to display dialog "Do you want to save this in your Keychain?" & return & return & "This is only asked on the first run" & return & return & "If you select no you will be prompted everytime for your password" buttons {"Yes", "No"} default button "No" giving up after 5 with title name of me with icon caution
			if button returned of b is "Yes" then
				if button returned of b is "Yes" then
					set b to display dialog "ARE YOU SURE YOU KNOW WHAT YOU ARE DOING?" buttons {"Yes", "No"} default button "No" with title name of me with icon stop
					if button returned of b is "Yes" then
						--	display dialog "Saving in keychain"
						my_Prefs("set", "yes")
						--	do shell script "defaults write AnyConnectSavePwd -bool 1"
						--	do shell script "security add-generic-password -a AnyConnectDuo -w " & quoted form of myPassword & " -j 'Used by Applescript AnyConnect with DUO' -s AnyConnectDuo"
					end if
				end if
			end if
			-- do shell script "defaults write AnyConnectSavePwd -bool 0"
			my_Prefs("saved", "no")
		end try
		set returnValue to myPassword
	else
		if action is "delete" then
			set returnValue to myPassword
		end if
	end if
	set returnValue to myPassword

	return returnValue
end KeyChainer

-- Read the VPN Legal Warning and accept.

on legalWarning()
	set autoOkPropName to "autoOk"

	try
		set autoOk to do shell script "defaults read com.cisco." & prefsName & " legalwarning"

		set autoOk to (autoOk = "1")
	on error -- no previous setting
		activate
		set b to display dialog "Acknowledge you have read the below legal message." & return & "You MUST read the text at least once, and promise to hum the words to yourself every time you log in." & return & return & "NOTE: DO NOT dial emergency response numbers (e.g. 911,112) from software telephony clients." & return & "Your exact location and the appropriate emergency response agency may not be easily identified." & return & return & "The following countries restrict use of VoIP software via VPN over the Internet: UAE, Saudi Arabia, Pakistan, Lebanon, Jordan, Egypt, Oman, Qatar, Yemen, Algeria and Kuwait." buttons {"Acknowledged"} default button "Acknowledged" with title "Acknowledge Legal Notice" with icon caution
		set autoOk to "1"
		-- call my_Prefs handler instead
		my_Prefs("set", "autoOk")
		-- do shell script "defaults write " & quoted form of prefName & " " & quoted form of autoOkPropName & " -bool '" & autoOk & "'"
		set autoOk to (autoOk = "1")
	end try
end legalWarning
-- Read the VPN Legal Warning and acknowledge


-- Make sure AnyConnect is started and active
--Check connection state and provide disconnect action if connected

on checkConnection()
	set AppName to "Cisco AnyConnect Secure Mobility Client"
	tell application AppName to activate
	tell application "System Events"
		set AppProc to application process AppName
		-- Make sure the main "Connect" window is open
		click menu item "Show AnyConnect Window" of menu 1 of menu bar item "Cisco AnyConnect Secure Mobility Client" of menu bar 1 of AppProc
		set ACWindow to item 1 of (windows of AppProc whose description is "standard window" and title is "")
		-- Check if we can start a new session

		if (static texts of ACWindow whose value is "Ready to connect.") is {} then
			--display dialog "Not ready to connect" buttons {"Quit"} cancel button "Quit" with title name of me
			set b to display dialog "Maybe already connected?" buttons {"Disconnect", "Quit"} default button "Disconnect" with title name of me
			if button returned of b is "Disconnect" then
				click button "Disconnect" of ACWindow
				tell application "Cisco AnyConnect Secure Mobility Client.app" to quit
				display notification "VPN Disconnected by User" with title "Duo AnyConnect"

				return
			else if button returned of b is "Quit" then

				return

			end if
		end if
	end tell -- trying some new end tell statements.
end checkConnection

--Connect VPN
on getConnected()
	set AppName to "Cisco AnyConnect Secure Mobility Client"

	tell application "System Events"
		set AppProc to application process AppName
		-- Make sure the main "Connect" window is open
		click menu item "Show AnyConnect Window" of menu 1 of menu bar item "Cisco AnyConnect Secure Mobility Client" of menu bar 1 of AppProc
		set ACWindow to item 1 of (windows of AppProc whose description is "standard window" and title is "")
		-- TO HERE
		-- Kick off connection to VPN server
		click button "Connect" of ACWindow

		-- Wait for Duo Window to pop up
		repeat while (windows of AppProc whose title is "Cisco AnyConnect Login") is {}
			delay 0.1
		end repeat

		set DuoWindow to item 1 of (windows of AppProc whose title is "Cisco AnyConnect Login")
		perform action "AXRaise" of DuoWindow

		-- Shortcut to HTML content in the Duo window UI element hierarchy
		set DuoHTMLArea to {}
		repeat while DuoHTMLArea is {}
			set DuoHTMLArea to my RecurseUIForElem(DuoWindow, "AXWebArea", "Cisco.com Login Page")
		end repeat

		-- Assume local username == CEC username
		set UserName to system attribute "USER"
		set UserName to UserName & "@cisco.com"
		set UserNameTextField to {}
		set PasswordTextField to {}

		repeat while PasswordTextField is {}
			repeat while UserNameTextField is {}
				set UserNameTextField to my RecurseUIForAttribute(DuoHTMLArea, "AXPlaceholderValue", "email")
			end repeat
			set PasswordTextField to my RecurseUIForAttribute(DuoHTMLArea, "AXPlaceholderValue", "Password")
		end repeat

		--	set value of UserNameTextField to UserName
		set value of UserNameTextField to UserName
		--set contents of attribute "Password" to UserToken
		set value of PasswordTextField to userToken
		-- We can search through the UI Element hierarch for the password field, but a direct keystroke is much faster
		keystroke return


		(*
		try
			-- TRYING TO HANDLE INCORRECT PASSWORD ENTRY
			repeat while DuoHTMLArea is {}
				set resetPassword to my RecurseUIForElem(DuoWindow, "AXWebArea", "Incorrect Password")
			end repeat

			--	display dialog resetPassword
			display dialog "Incorrect Password" & return & return & "Would you like to reset your password?" buttons {"Reset Password", "Quit"} default button "Reset Password"
			if result = {button returned:"Quit"} then

				tell application "Cisco AnyConnect Secure Mobility Client" to quit

			else if result = {button returned:"Reset Password"} then
				--	display dialog "Clearing Settings" giving up after 2
				try
					do shell script "security delete-generic-password -a AnyConnectDuo"
				end try
				try
					do shell script "defaults delete AnyConnectSavePwd"
				end try

				tell application "Cisco AnyConnect Secure Mobility Client" to quit

			end if
		*)

		-- Wait for Duo Device chooser popup
		set Popup to {}
		repeat while Popup is {}
			delay 0.1
			set Popup to my RecurseUIForElem(DuoHTMLArea, "AXPopUpButton", "Device")
		end repeat

		-- Get Yubikey token
		set dialogResult to display dialog "Touch Yubikey now..." default answer "" buttons {"OK"} default button "OK" with title "Get YubiKey-OTP -> " & name of me
		repeat until length of text returned of dialogResult is 44
			set dialogResult to display dialog "Invalid Yubikey token" & return & "Quit or Retry touching Yubikey now..." default answer "" buttons {"Retry", "Quit"} with title name of me
			if button returned of dialogResult is "Quit" then
				set DuoCloseButton to my RecurseUIForElem(DuoWindow, "AXButton", "close button")
				click DuoCloseButton
				error "User canceled." number -128
				display notification "User Cancelled" with title "Duo AnyConnect"
			end if
		end repeat

		-- Choosable menu doesn't appear in hierarch until this popup button is clicked
		click Popup

		-- Choose Yubikey token
		delay 0.1
		click menu item "Token" of menu 1 of group 1 of DuoWindow

		set PasscodeButton to my RecurseUIForElem(DuoHTMLArea, "AXButton", "Enter a Passcode")
		click PasscodeButton

		-- Find Field to enter Yubikey token
		set TokenField to {}
		repeat while TokenField is {}
			set TokenField to my RecurseUIForAttribute(DuoHTMLArea, "AXPlaceholderValue", "(ex. 867539)")
		end repeat
		set value of TokenField to text returned of dialogResult

		-- A bit quicker to search for Login button starting at more recent ancestor
		set UIGrandParent to my GetUIAncestor(TokenField, 2)

		-- Send entered Yubikey token
		set LoginButton to {}
		repeat while LoginButton is {}
			set LoginButton to my RecurseUIForElem(UIGrandParent, "AXButton", "Log In")
		end repeat
		click LoginButton

		-- Click "accept" button, once it is available
		repeat while (windows of AppProc whose title is "Cisco AnyConnect - Banner") is {}
			delay 0.1
		end repeat
		click button "Accept" of window "Cisco AnyConnect - Banner" of AppProc
		display notification "VPN Connected" with title "Duo AnyConnect"
	end tell
end getConnected

on my_Prefs(action, theKeyValue)
	if action is "set" and theKeyValue is "yes" then
		do shell script "defaults write com.cisco." & prefsName & " saved" & " '" & theKeyValue & "'"
		do shell script "security add-generic-password -a " & prefsName & "  -w " & quoted form of myPassword & " -j 'Used by Applescript Deskpro Volume' -s" & prefsName
	else if action is "set" and theKeyValue is "no" then
		do shell script "defaults write com.cisco." & prefsName & " saved" & " '" & theKeyValue & "'"
	else if action is "set" and theKeyValue is "autoOk" then
		do shell script "defaults write com.cisco." & prefsName & " legalwarning" & " ' 1'"
	else if action is "reset" and theKeyValue is "clear" then
		try
			do shell script "defaults delete com.cisco." & prefsName & " saved"
		end try
		try
			do shell script "defaults delete com.cisco." & prefsName & " legalwarning"
		end try
		try
			do shell script "security delete-generic-password -a " & prefsName
		end try
	else if action is "reset" and theKeyValue is "resetpwd" then
		--	try
		--		do shell script "defaults delete com.cisco." & prefsName & " saved"
		--	end try
		try
			do shell script "security delete-generic-password -a " & prefsName
		end try
	end if
end my_Prefs


(*
Start of main script
*)


-- Walk user though enabling UI automation
set myname to name of current application
if myname is "osascript" then
	set myname to "Script Menu"
end if
tell application "System Events" to set isUIScriptingEnabled to UI elements enabled
if isUIScriptingEnabled = false then
	tell application "System Preferences"
		activate
		display notification "Please follow instructions when they appear" with title (name of me) as text subtitle "Loading Security & Privacy Preferences..."
		set current pane to pane "com.apple.preference.security"
		tell current pane to reveal anchor "Privacy_Accessibility"
		-- Activate again so the dialog box will appear on top
		activate
		display dialog "Your system needs a one-time configuration to run this script." & return & return & "In \"System Preferences... -> Security & Privacy -> Privacy\":" & return & return & "1. Unlock \"Click the lock to make changes\"" & return & "2. Select \"Click Accessibility\"" & return & "3. Select checkbox next to: \"" & myname & "\"" & return & "4. Re-run the script to proceed." with title name of me buttons {"OK"} cancel button "OK" with icon note
		quit
	end tell
end if

-- Check if we actually have a Yubikey plugged in. If not plugged in give user option to reset preferences or quit.
try
	do shell script "system_profiler SPUSBDataType 2>/dev/null | grep -i 'YubiKey.*OTP'"
on error errStr number errorNumber
	if the errorNumber is equal to 1 then
		set dialogResult to display dialog "Yubikey OTP device not detected please connect manually" buttons {"Reset Password", "Clear Settings", "Quit"} default button "Quit" cancel button "Quit" with title name of me giving up after 3
		if button returned of dialogResult is "Clear Settings" then
			-- clear keychain items if exists
			try
				do shell script "security delete-generic-password -a " & prefsName
			end try
			-- clear auto accept preference
			try
				do shell script "defaults delete com.cisco." & prefsName
			end try
		else if button returned of dialogResult is "Reset Password" then

			my_Prefs("reset", "resetpwd")

			-- clear save preference
			--	try
			--	do shell script "defaults delete com.cisco." & prefsName
			--	end try
		end if
		return ""
	else
		error errStr number errorNumber
	end if
end try

-- run legal warning if not acknowledged previously
try
	set autoOk to do shell script "defaults read " & quoted form of prefName & " " & quoted form of autoOkPropName
	set autoOk to (autoOk = "1")
on error -- no previous setting
	legalWarning()
end try

checkConnection()
set userToken to KeyChainer("get")
getConnected()

(*end of main script*)