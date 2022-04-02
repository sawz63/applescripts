#@osa-lang:AppleScript

use AppleScript version "2.4" -- Yosemite (10.10) or later -- tested on OS X 12.3 Montery 1 April 2022
use scripting additions

(*

Developed by: Pete Sawyer
Version v0.1.1

One of the things I didn't like about the Deskpro was not being able to select different volume levels for Mactone, in call and PC individually. I was constantly reaching over to change the volume settings. My in call volume was too loud for the ringtone and PC output, the ringtone volume I wanted was too low for in call volume, etc... So I created this script to change the volume from my keyboard. It uses xml via the https API to get status and send commands to the Deskpro.

https://www.cisco.com/c/dam/en/us/td/docs/telepresence/endpoint/ce915/collaboration-endpoint-software-api-reference-guide-ce915.pdf

This script is to be used at your own discretion. I use a program called "FastScripts" to assign a keyboard shortcut to run the script. I can simply hit my keyboard combination, select the volume I want from the pre-assigned values for "Mac"  "Call" or "Mute" and the script will adjust the volume on the Deskpro.
Fastscripts can be downloaded from the App Store or a free version limited to 10 keyboard shortcuts is available https://redsweater.com/fastscripts/

The script works for my purposes to change the volume, answer a call, and control an "in call" status light outside my office door from a keyboard shortcut on my Mac.


(* PREREQUISITES *)

You must have access to the Deskpro in order for the script to connect. This can be enabled via the ACE Dashboard under devices at ace.cisco.com Select enable admin access, connect to the deskpro and create a user.

Your Mac must be able to connect to the Deskpro, some network scenarios may not work, i.e. Deskpro on personal network, Mac on CVO or VPN.

Set the following variables to match your system requirements. "theMacVolume, theCallVolume, and theMuteVolume"

On first run the script will prompt you for the following:
 1. Your Deskpro IP Address or hostname. If you provide the hostname it must
 	be DNS resolvable, otherwise simply provide the IP address.
 2. The Deskpro username that has permission to connect and make changes to the Deskpro. The script will store the username
	 in com.cisco.Deskpro.<username>
 3. The deskpro password. This is the password for you deskpro user. The password is used along with our username to create a base64url hash that is stored in the keychain and used by the script to connect to the deskpro.
 4. When in a call the script will allow you to change between microphone muted and unmuted. It will also allow you to disconnect the call.
 5. When not in a call the script will allow you to change between the pre-defined volume settings. If you select "yes" you will be prompted for the prerequisites to control the TP-Link device. You will need your KASA KEY and the Device IDs.
 6. The script will ask if you want to control an TP-Link smart plug(s). This can be used as an "In Call" indicator. The use case I have for this is a TP-Link plug outside my office door in the hallway. I have a small red night light plugged into the TP-Link. When I'm in a call it turns on, when I disconnect (with the script) it turns off. Or it will turn off when not in a call and you run the script to change the volume setting.

	(* KASA PLUG CONTROL *)
	(* Changed to local direct control via python-kasa *)
	(* Requires python-kasa be installed on your system https://python-kasa.readthedocs.io/en/latest/index.html *)
*)

(* INSTRUCTIONS *)

(* USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND *)
(* Lines at the end of the script also have to be commented out or included *)
--set mgRightNow to "perl -e 'use Time::HiRes qw(time); print time'"
--set mgStart to do shell script mgRightNow

(* ############################################ *)
(* ################ USER VARIABLES ################ *)
(* ############################################ *)
(* set different volume levels to match your specific requirements by changing these values *)
set theMacVolume to "25"
set theCallVolume to "60"
set theMuteVolume to "0"

(* prefsName is the variable for preference panes and keychain naming for user preferences and securityfor example if set to TESTME the preference pane would be com.cisco.TESTME and the keychain entry would be TESTME.<DESKPRO_USER> . You can safely change this to anything you want the preferences and keychain to show up as. If you do not set this variable the default of the script name will be used *)
set prefsName to "Deskpro Volume Utility"
if prefsName is "" then
	set prefsName to my name as text
end if

(* ############################################ *)
(* ############# END OF USER VARIABLES ############# *)
(* ############################################ *)

(* NO CHANGES BELOW HERE *)

(* Make variables globally available to the script *)

property muteStatus : ""
property theCurrVolume : ""
property answeredState : ""
property callDuration : ""
property theVolume : ""
property callStatus : ""
property theVolMute : ""
property theCleanText : ""

global theHost
global theEnd
global theUser
global thePwd
global theMacVolume
global theCallVolume
global theMuteVolume
global BadPWDchars
global tryPWD
global prefsName
global micState
global AutoAnswer


global tplink
global myTPLinkDevices
global newKasaDevices
global myUUIDv4
global myBase64Url

global getCmd
global grep_for
global theVar
global the2ndVar
global myCmdStart
global myCmdEnd
global myCmd
global my2ndCmd
global postCmd
global currValue
global selfcert

set BadPWDchars to {"!", "[", "]", "{", "}"}
set my2ndCmd to {}

-- Walk user though enabling UI automation
set myname to name of current application as text
if myname is "runme_install_DVU" then
else
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
end if


get_PreReqs("getPrefs")

(*If Auto Answer was selected check to see if there is an incoming call, If so answer it; check if connected or in some state of connecting; set the tplink to the correct state, set the volume to in call level*)
--on get_AutoAnswer(AutoAnswer)
(* check to see if the Deskpro is ringing, if so answer it and set the tplink  to on, set the volume to in call level *)
if AutoAnswer is "Yes" then
	try
		get_xml()
		if callStatus contains "Ringing" then
			set theVar to ""
			set the2ndVar to theCallVolume
			set callStatus to "1"
			set_tplink("on")
			set myCmd to {"Command", "Call", "Accept"}
			set my2ndCmd to {"Command", "Audio", "Volume", "Set command=\"True\"", "Level"}
			post_cmd()
			return
		else if callStatus contains "Connecting" or callStatus contains "Dialling" then
			set_tplink("on")
			set theVar to theCallVolume
			set myCmd to {"Command", "Audio", "Volume", "Set command=\"True\"", "Level"}
			post_cmd()
			return
			--	set callStatus to "1"
		else if callStatus contains "Connected" then
			set callStatus to "1"
		else
			set callStatus to "0"
		end if
	on error
		set callStatus to "0"
	end try
	get_Volume()
else if AutoAnswer is "No" then
	get_xml()
	if tplink is "1" then
		try
			if theCallStatus contains "Ringing" or theCallStatus contains "Connected" or theCallStatus contains "Connecting" or theCallStatus contains "Dialling" then
				set callStatus to "1"
			else
				set callStatus to "0"
			end if
		on error
			set callStatus to "0"
		end try
	end if
	get_Volume()
end if

(*get the current volume state, toggle between call and Mac volume, allow volume selection*)
on get_Volume()
	if callStatus is "0" then
		set_tplink("off")
		try --
			get_xml()
		on error
			return
		end try
		if theCurrVolume is less than theCallVolume then
			set b to display dialog "				Select your volume preference" buttons {"Mute", "In Call", "Mac"} default button "In Call" giving up after 5 with title name of me
		else -- if currVolume is greater than theMacVolume then
			set b to display dialog "				Select your volume preference" buttons {"Mute", "In Call", "Mac"} default button "Mac" giving up after 5 with title name of me
		end if
		if button returned of b is "Mac" then
			set theVar to theMacVolume
		else if button returned of b is "In Call" then
			set theVar to theCallVolume
		else if button returned of b is "Mute" then
			set theVar to theMuteVolume
		else
			error number -128
		end if
	else if callStatus is "1" then
		set_tplink("on")
		try
			set theVar to ""
			set the2ndVar to ""
			if callDuration is less than "30" then
				set theVar to theCallVolume
				set myCmd to {"Command", "Audio", "Volume", "Set command=\"True\"", "Level"}
				post_cmd()
			end if
			if muteStatus is "On" and theVolMute is "On" then -- option 1 mic and vol are both muted, unmute volume or unmute both
				set b to display dialog "				Select your mute preference" buttons {"UnMute Vol", "UnMute All", "Disconnect"} default button "UnMute All" giving up after 5 with title name of me
			else if muteStatus is "On" and (theVolMute is "Off" and theCurrVolume is not less than theCallVolume) then -- option 2 mic is muted volume is not, option to unmute mic or mute vol so that both are mute
				set b to display dialog "				Select your mute preference" buttons {"UnMute Mic", "Mute Vol", "Disconnect"} default button "UnMute Mic" giving up after 5 with title name of me
			else if muteStatus is "On" and (theVolMute is "Off" and theCurrVolume is less than theCallVolume) then -- option 3 mic is muted volume is lower that thecallvolume but not mute, option to unmute mic or mute all
				set b to display dialog "				Select your mute preference" buttons {"UnMute Mic", "Mute All", "Disconnect"} default button "UnMute Mic" giving up after 5 with title name of me
			else if muteStatus is "Off" and (theVolMute is "On" and theCurrVolume is less than theCallVolume) then -- option 4 if for some reason the mic is not mute but the volume is, option to mute mic or unmute all
				set b to display dialog "				Select your mute preference" buttons {"Mute Mic", "UnMute All", "Disconnect"} default button "UnMute All" giving up after 5 with title name of me
			else if muteStatus is "Off" and theVolMute is "Off" then -- option 5 neither mic and volume are mute, option to mute mic or mute all
				set b to display dialog "				Select your mute preference" buttons {"Mute Mic", "Mute All", "Disconnect"} default button "Mute Mic" giving up after 5 with title name of me
			end if
			if button returned of b is "UnMute Mic" then
				set myCmd to {"Command", "Audio", "Microphones", "UnMute"}
				post_cmd()
				return
			else if button returned of b is "UnMute Vol" then
				set myCmd to {"Command", "Audio", "Volume", "UnMute"}
				post_cmd()
				return
			else if button returned of b is "UnMute All" then
				set myCmd to {"Command", "Audio", "Microphones", "UnMute"}
				set my2ndCmd to {"Command", "Audio", "Volume", "UnMute"}
				post_cmd()
				return
			else if button returned of b is "Mute Mic" then
				set myCmd to {"Command", "Audio", "Microphones", "Mute"}
				post_cmd()
				return
			else if button returned of b is "Mute Vol" then
				set myCmd to {"Command", "Audio", "Volume", "Mute"}
				post_cmd()
				return
			else if button returned of b is "Mute All" then
				set myCmd to {"Command", "Audio", "Microphones", "Mute"}
				set my2ndCmd to {"Command", "Audio", "Volume", "Mute"}
				post_cmd()
				return
			else if button returned of b is "Disconnect" then
				set myCmd to {"Command", "Call", "Disconnect"}
				set my2ndCmd to {"Command", "Audio", "Volume", "Set command=\"True\"", "Level"}
				set the2ndVar to theMacVolume
				post_cmd()
				set_tplink("off")
				set callStatus to "0"
				return
			else
				error number -128
			end if
		on error
			error number -128
		end try
	end if
	set myCmd to {"Command", "Audio", "Volume", "Set command=\"True\"", "Level"}
	post_cmd()
end get_Volume

(* get the prerequisite user variables for the script *)
on get_PreReqs(action)
	if action is "getPrefs" then
		try -- check to see if a hostname has been previously saved and use it
			set theHost to do shell script "defaults read com.cisco." & quoted form of prefsName & " hostname"
		on error -- no previous username entry
			display dialog "The Script was unable to read your preferences." & return ¬
				& "Please have the following information available for input." & return & return ¬
				& "Deskpro hostname or IP address:" & return ¬
				& "Deskpro Username:" & return & "Deskpro password for user:" & return ¬
				& "Ignore Self Signed Cert Yes/No:" & return & "Auto Answer Calls Yes/No:" & return & return ¬
				& "If you want to control a TP-Link Device: Yes/No" & return & return ¬
				& "If you selected yes to control the TP-Link Device you will need:" & return ¬
				& "TP-Link KASA ID:" & return & "TP-Link Device ID(s):" & return & return ¬
				& "You can select \"Cancel\" if you do not have this information available now." & return & return ¬
				& "Instructions are located at the top of the script, open with a text application or script editor to read." with title name of me
			set b to display dialog ("What is your Deskpro IP address or Hostname?") default answer "" with title name of me
			set theHost to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " hostname" & " '" & theHost & "'"
		end try
		try -- check to see if a username has been previously saved
			set theUser to do shell script "defaults read com.cisco." & quoted form of prefsName & " username"
		on error -- no previous username entry
			set b to display dialog ("What is your Deskpro Username?") default answer "" with title name of me
			set theUser to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " username" & " '" & theUser & "'"
		end try
		try -- check to see if a base64url has been previously saved
			set myBase64Url to do shell script "security find-generic-password -wl " & quoted form of prefsName & "." & theUser
		on error -- no previous base64url in keychain
			set tryPWD to ""
			repeat until tryPWD is true
				set passwordq to display dialog ("What is your Deskpro Password?") default answer "" with title name of me with hidden answer
				set thePwd to text returned of passwordq
				set tryPWD to pwdOK(thePwd) (* Check the password entered for invalid characters *)
			end repeat
			display notification ("Calculating base64url") with title name of me
			set myBase64Url to do shell script "printf " & theUser & ":" & thePwd & " | base64"
			do shell script "security add-generic-password -a " & quoted form of prefsName & "  -w " & quoted form of myBase64Url & " -j 'Used by Applescript Deskpro Volume' -s" & quoted form of prefsName & "." & theUser
		end try
		try -- check to see if ignore self_signed_cert has been set
			set selfcert to do shell script "defaults read com.cisco." & quoted form of prefsName & " ignore_self_signed_cert"
		on error -- no previous autoanswer entry to ignore the self signed cert we inject a -k into the curl commands
			set b to display dialog ("Do you want the script to ignore the default Deskpro Self Signed Cert?" & return & return & " Set this to no if you have a valid cert on the deskpro") buttons {"Yes", "No"} default button "Yes" with title name of me
			if button returned of b is "Yes" then
				set selfcert to "-k"
				do shell script "defaults write com.cisco." & quoted form of prefsName & " ignore_self_signed_cert" & " '-k'"
			else
				set selfcert to ""
				do shell script "defaults write com.cisco." & quoted form of prefsName & " ignore_self_signed_cert" & " ''"
			end if
		end try
		try -- check to see if Auto Answer has been set
			set AutoAnswer to do shell script "defaults read com.cisco." & quoted form of prefsName & " AutoAnswer"
		on error -- no previous autoanswer entry
			set b to display dialog ("Do you want the script to be able to answer incoming calls?") buttons {"Yes", "No"} default button "Yes" with title name of me
			set AutoAnswer to result
			do shell script "defaults write com.cisco." & quoted form of prefsName & " AutoAnswer" & " 'Yes'"
		end try

		try -- check to see if a call volume has been previously saved
			set theCallVolume to do shell script "defaults read com.cisco." & quoted form of prefsName & " volume_call"
		on error -- no previous username entry
			set b to display dialog ("What is your preferred volume while in a call?") default answer "55" with title name of me
			set theCallVolume to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " volume_call" & " '" & theCallVolume & "'"
		end try
		try -- check to see if a Mac Volume has been previously saved
			set theMacVolume to do shell script "defaults read com.cisco." & quoted form of prefsName & " volume_Mac"
		on error -- no previous username entry
			set b to display dialog ("What is your preferred volume for Mac Speaker output?") default answer "20" with title name of me
			set theMacVolume to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " volume_Mac" & " '" & theMacVolume & "'"
		end try
		try
			if (do shell script "defaults read com.cisco." & quoted form of prefsName & " tplink_control") is "1" then
				set tplink to "1"
				try
					set myTPLinkDevices to do shell script "defaults read com.cisco." & quoted form of prefsName & " TPLink_devices"
				on error
					set newTPLinkDevice to "1"
					set myTPLinkDevices to {}
					repeat until newTPLinkDevice is ""
						set newTPLinkDevice to display dialog "Enter your TP-Link device Id" default answer "" with title name of me
						set newTPLinkDevice to text returned of newTPLinkDevice
						if newTPLinkDevice is not "" then
							set the end of myTPLinkDevices to newTPLinkDevice & "\\r"
						end if
					end repeat
					do shell script "defaults write com.cisco." & quoted form of prefsName & " TPLink_devices" & " '" & myTPLinkDevices & "'"
				end try
			else
				set tplink to "0"
			end if
		on error
			set c to display dialog ("Do you want the script to control an In-Call Status Light?") buttons {"Yes", "No"} default button "Yes" with title name of me
			if button returned of c is "Yes" then
				do shell script "defaults write com.cisco." & quoted form of prefsName & " tplink_control" & " '1'"
				set tplink to "1"
			else
				do shell script "defaults write com.cisco." & quoted form of prefsName & " tplink_control" & " '0'"
				set tplink to "0"
			end if
			get_PreReqs("getPrefs")
		end try

	end if
	return
end get_PreReqs

on post_cmd()
	set myCmdStart to {}
	set myCmdEnd to {}
	set newCmd to items of myCmd
	repeat with newElement in newCmd
		if newElement is not "" then
			set the end of myCmdStart to "<" & newElement & ">"
			if newElement contains "Set command=\"True\"" then
				set newElement to "Set"
			end if
			set the beginning of myCmdEnd to "</" & newElement & ">"
		end if
	end repeat
	set postCmd to selfcert & " --location --request POST \"https://" & theHost & "/putxml\" --header 'Authorization: Basic " & myBase64Url & "' --header 'Content-Type: text/plain' --data-raw '" & myCmdStart & theVar & myCmdEnd & "'  "

	if my2ndCmd is not {} then
		set my2ndCmdStart to {}
		set my2ndCmdEnd to {}
		set new2ndCmd to items of my2ndCmd
		repeat with new2ndElement in new2ndCmd
			if new2ndElement is not "" then
				set the end of my2ndCmdStart to "<" & new2ndElement & ">"
				if new2ndElement contains "Set command=\"True\"" then
					set new2ndElement to "Set"
				end if
				set the beginning of my2ndCmdEnd to "</" & new2ndElement & ">"
			end if
		end repeat
		set postCmd to postCmd & " -: " & selfcert & "  --location --request POST \"https://" & theHost & "/putxml\" --header 'Authorization: Basic " & myBase64Url & "' --header 'Content-Type: text/plain' --data-raw '" & my2ndCmdStart & the2ndVar & my2ndCmdEnd & "'"
	end if
	do shell script "curl " & postCmd & " &> /dev/null " (* Send the command to the device *)
end post_cmd

on get_xml()
	set grep_for to " -e \"<Status>\" -e \"Duration\" -e \"Answer\" -e \"Mute\" -e \"VolumeInternal\" "
	set theStatusResults to paragraphs of (do shell script "curl -k --location --request GET \"https://" & theHost & "/getxml?location=/Status\" --header 'Authorization: Basic " & myBase64Url & "'   | grep " & grep_for)
	try
		set muteStatus to word 4 of item 9 of theStatusResults
		set theCurrVolume to word 4 of item 10 of theStatusResults
		set theVolMute to word 4 of item 11 of theStatusResults
		set answeredState to word 4 of item 13 of theStatusResults
		set callDuration to word 4 of item 14 of theStatusResults
		set callStatus to word 4 of item 15 of theStatusResults
	end try
	--	display dialog "Deskpro Call States" & return & "Call Status: " & callStatus & return & "Call Duration: " & callDuration & return & "Answered State: " & answeredState & return & return & "Deskpro Volume States" & return & "Current Volume is: " & theCurrVolume & return & "The Mic Mute State is: " & muteStatus
end get_xml

(* CONTROL TP-LINK SMART OUTLET as "In Call" status indicator *)
on set_tplink(state)
	if tplink is "1" then
		try
			repeat with myDeviceid in words of myTPLinkDevices
				set myDeviceid to myDeviceid -- of myTPLinkDevices
				do shell script "/usr/local/bin/kasa --host " & myDeviceid & " " & state
			end repeat
		end try
	end if
end set_tplink

-- Verify that a thePwd does not contain any characters that will break the base64 command
on pwdOK(thePwd)
	set PWDchars to characters of thePwd
	repeat with ch in PWDchars
		if ch is in BadPWDchars then
			return false
		end if
	end repeat
	return true
end pwdOK

on removeMarkupFromText(theText)
	set tagDetected to false
	set theCleanText to ""
	repeat with a from 1 to length of theText
		set theCurrentCharacter to character a of theText
		if theCurrentCharacter is "<" then
			set tagDetected to true
		else if theCurrentCharacter is ">" then
			set tagDetected to false
		else if tagDetected is false then
			set theCleanText to theCleanText & theCurrentCharacter as string
		end if
	end repeat
	return theCleanText
end removeMarkupFromText

(* USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND *)
--set mgStop to do shell script mgRightNow
--set mgRunTime to mgStop - mgStart
--display dialog "This took " & mgRunTime & " seconds." & return & "that's " & (round (mgRunTime * 1000)) & " milliseconds."

