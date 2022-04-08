#@osa-lang:AppleScript
(*

Written by: Pete Sawyer May 7, 2021 current version v0.05

v0.05 changes 09 May 2021
split script into 2 separate scripts, one for Deskpro and one for TP-Link Smart Outlet control.
combined ssh fingerprint handler expect script and main expect script for efficiency.
added prefsname default action to autoassign the script name as the default unless specifically set by user.


v0.04 changes 07 May 2021
fixed password reset functionality
incorrect password or non-exist password will now prompt you for the password, it will check if "saved" is set in preferences. It will create or delete the keychain item depending on this setting. If the setting does not exist it will prompt you for your preference to save the keychain item or not.
added options to myPrefs handler to accommodate password reset functionality

v.0.03 changes 05 May 2021
added TP-Link KASA smart plug control
added Auto Answer if the Deskpro is ringing, connected, connecting or dialing, set TP-Link light on, set volume to in call level.
added KASA outlet control if you are "connected, connecting, or dialing" the outlet will be turned to the on state .
TP-Link KASA handler can be commented out if you do not want to control one of these devices.
The KASA handler will cycle through a list of KASA devices and set the state on all of them. Simply edit the myKasaDevices list to include one or more devices.
The KASA handler requires you have your UUIDv4, KASA Token and Device IDs in order to function. Instruction are below where these variables are set in the script. Edit for you specific information.
fixed expect script to work with DX devices.

v.0.02 changes 04 May 2021
created Preferences file to store options
added "first run" logic to get your specific settings and store them in the Preferences file
added logic to accept the ssh fingerprint if you don't already have an entry in your .ssh/known_hosts file

v.0.01 created initial script  26 April 2021


One of the thing I didn't like about the Deskpro was not being able to select different volume levels for ringtone, in call and PC individually. I was constantly reaching over to change the volume settings. My in call volume was too loud for the ringtone and PC output, the ringtone volume I wanted was too low for in call volume, etc... So I created this script to change the volume from my keyboard. It connects to the Deskpro via SSH and uses "expect" command line scripting to send commands to the Deskpro using  xCommand with the terminal API.

https://www.cisco.com/c/dam/en/us/td/docs/telepresence/endpoint/ce915/collaboration-endpoint-software-api-reference-guide-ce915.pdf

This script is to be used at your own discretion. I use a program called "FastScripts" to assign a keyboard shortcut to run the script. I can simply hit my keyboard combination, select the volume I want from the pre-assigned values for "Ring"  "Call" or "Mute" and the script will adjust the volume on the Deskpro.

The script works for my purposes to quickly change the volume, answer a call, and control an "in call" status light outside my office door from a keyboard shortcut on my Mac.

(* PREREQUISITES *)

You must have access to the Deskpro in order for the script to connect. This can be enabled via the ACE Dashboard under devices at ace.cisco.com Select enable admin access, connect to the deskpro and create a user. The only permissions required for the script user is "User".

Set the following variables to match your system requirements. "prefsName, theRingVolume, theCallVolume, and theMuteVolume"

On first run the script will prompt you for the following:
 1. Your Deskpro IP Address or hostname. If you provide the hostname it must
 	be DNS resolvable, otherwise simply provide the IP address.
 2. The Deskpro username that has permission to connect and make changes to the Deskpro. The script will store the username
	 in com.cisco.Deskpro.
 3. The deskpro password. You have the option to store this in your keychain. Ensure this is NOT your CEC password.
 4. Accept the ssh fingerprint from the deskpro.

*)

(* INSTRUCTIONS *)

(* USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND *)
(* Lines at the end of the script also have to be commented out or included *)
set mgRightNow to "perl -e 'use Time::HiRes qw(time); print time'"
set mgStart to do shell script mgRightNow

(* ############################################ *)
(* ################ USER VARIABLES ################ *)
(* ############################################ *)
(* set different volume levels to match your specific requirements by changing these values *)
set theRingVolume to "20"
set theCallVolume to "65"
set theMuteVolume to "0"

(* prefsName is the variable for preference panes and keychain naming for user preferences and securityfor example if set to TESTME the preference pane would be com.cisco.TESTME and the keychain entry would be TESTME.<DESKPRO_USER> . You can safely change this to anything you want the preferences and keychain to show up as. If you do not set this variable the default of the script name will be used *)
set prefsName to "Deskpro Volume Utility"
if prefsName is "" then
	set prefsName to my name as text
end if

(*
(* KASA PLUG CONTROL *)
(* HOW TO GET UUID v4: https://www.uuidgenerator.net/version4 *)
(* HOW TO GET KASA TOKEN : https://itnerd.space/2017/06/19/how-to-authenticate-to-tp-link-cloud-api/ *)
(* HOW TO CONTROL A KASA SMART PLUG from the internet *)
(* https://itnerd.space/2017/01/22/how-to-control-your-tp-link-hs100-smartplug-from-internet/ *)
*)

(* To control a Kasa Smart Plug(s) edit the following information used in setStatusLight(state) *)
(* You can safely leave these variables as "" without risk. *)
(* If myUUIDToken is empty the script will not attempt to control the TP-Link KASA devices *)

(* Your UUIDv4 token *)
--set myUUIDToken to "adc1b44f-8971-43be-b731-1de6017e37e7"

(* Your Kasa Token *)
-- property myKasaToken : "95e6b323-ATr5ALCX7DSyH2bP3zIMlzB"
--set myKasaToken to "95e6b323-ATr5ALCX7DSyH2bP3zIMlzB"

(* Create a list of Kasa Smart Plugs to control *)
--set myKasaDevices to {"8006FDAF0DB9104D02049B1DE01201031DD93907", "80068F052FDBCECE3542A6491E8B52A61DD9AC7D"}

(* If you have a TP-Link smart plug you want to control set this to "1" other wise leave as "0" *)

-- set tplink to "1"
(*
set kasascript_name to "TPLink Plug Control For DVU.scpt"
if tplink is "1" then
	set tplink_script to ((path to scripts folder as text) & kasascript_name) as alias
end if
*)

(* ############################################ *)
(* ############# END OF USER VARIABLES ############# *)
(* ############################################ *)


(* NO CHANGES BELOW HERE *)

(* Make variables globally available to the script *)
property theVolume : ""
property callStatus : ""
global expectScript
global acceptfingerprintScript
global theHost
global theEnd
global theUser
global thePwd
global theCmd
global theRingVolume
global theCallVolume
global theMuteVolume
global BadPWDchars
global tryPWD
global prefsName
global state
global AutoAnswer
global tplink
global tplink_script

(* used to check password for bad characters *)
set BadPWDchars to {"#", "%", "^", "[", "]", "{", "}", "<", ">"}
(* Needed to terminate the connection to the deskpro *)
set theEnd to "bye"

-- Walk user though enabling UI automation
set myname to name of current application as text
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

(* start main script *)

--get_PreReqs("host")
get_PreReqs("getPrefs")

(* check to see if "First Run" is set *)
try
	set b to do shell script "defaults read com.cisco." & theHost & " firstrun"
	set b to result
on error
	get_PreReqs("sshfingerprint")
end try

(* input the preferred username or retrieve the saved username *)
get_User("get")

(* get the desired volume state *)
get_Volume()

(* action script to ssh to and interact with the host command line *)
on get_actionScript(action)
	set expectScript to "set timeout 10
spawn ssh " & theUser & "@" & theHost & "
expect {
 \"fingerprint\" {
       send \"yes
\"
       exp_continue
	   }
   \"Password:\" {
       send \"" & thePwd & "\\r\"
       exp_continue
   }
   \"Login successful\" {
       send \"" & action & "\\r\"
       exp_continue
   }
    \"end\" {
       send \"bye
\"
       exp_continue
   }
}"
end get_actionScript

(* run the action script *)
do shell script "expect <<<" & quoted form of expectScript

(* error handling *)
if result contains "Permission denied" then
	set b to display dialog "Incorrect Password" & return & return & "Check your password on the host. You may need to clear your preferences and keychain." buttons {"Reset All", "Reset", "Cancel"} default button "Reset" with title name of me
	if button returned of b is "Reset" then
		myPrefs("reset", "clear")
	else if button returned of b is "Reset All" then
		myPrefs("reset", "reset")
	else
		error number -128
	end if
else if result contains "fingerprint" then
	set b to display dialog "Something went wrong with the ssh fingerprint" & return & return & "You may need to clear your preferences and keychain." buttons {"Reset All", "Reset", "Cancel"} default button "Reset" with title name of me
	if button returned of b is "Reset" then
		myPrefs("reset", "sshreset")
	else if button returned of b is "Reset All" then
		myPrefs("reset", "reset")
	else
		error number -128
	end if
	get_PreReqs("sshfingerprint")
end if

(* TPLink control *)
if tplink is "1" then
	try
		run script tplink_script with parameters {state}
	end try
end if

(*end main script*)

(* get the currently logged on user information from the Mac *)
(* set preferencepane and keychain per user selections *)
(* sets ~/Library/Preferences/com.cisco.<prefsName>.<userid> preference to indicate whether or not to be prompted for your password every time *)
(* sets keychain item <prefsName>.<userid> to store your deskpro key. This must be different than our CEC password! *)
(* rewritten partly from John Wallis "keychainer" handler *)
on get_User(action)
	set returnValue to ""
	try
		set thePwd to do shell script "security find-generic-password -wl " & quoted form of prefsName & "." & theUser
	on error
		set thePwd to ""
	end try
	if (length of thePwd is 0) then
		-- Key not already on the KeyChain.    Prompt for it and add..
		set passwordq to display dialog ("What is your Deskpro Password?") default answer "" with title name of me with hidden answer
		set thePwd to text returned of passwordq
		(* Check the password entered for invalid characters *)
		set tryPWD to pwdOK(thePwd)
		if tryPWD is true then
			try
				set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " saved" -- does preference exist?
				if b is "yes" then
					myPrefs("set", "create")
				else if b is "no" then
					try
						myPrefs("set", "delete") -- make sure keychain item is deleted
					end try
				end if
			on error -- no previous setting
				set b to display dialog "Do you want to save this in your Keychain?" & return & return & "This is only asked on the first run." & return & return & "If you select no, you will be prompted every time for your password" & return & return & "Make SURE this password is NOT your CEC password!!!" buttons {"Yes", "No"} default button "No" giving up after 5 with title name of me
				if button returned of b is "Yes" then
					myPrefs("set", "yes")
				else if button returned of b is "No" then
					myPrefs("set", "no")
				end if
			end try
		else
			(* Error handling for invalid characters *)
			display dialog "Password contains invalid characters. The script will not function" & return & return & "The script will now exit" buttons {"Exit"} cancel button {"Exit"} with title name of me with icon stop
			error number -128
		end if
	end if
	set tryPWD to pwdOK(thePwd)
	if tryPWD is true then
		set returnValue to thePwd
	else
		(* A error handling for invalid characters *)
		myPrefs("reset", "clear")
		display dialog "Password contains invalid characters. Password was reset." & return & return & "Please rerun the script." & return & return & "The script will now exit" buttons {"Exit"} cancel button {"Exit"} with title name of me with icon stop
	end if
	return returnValue
end get_User


(*get the current volume state, toggle between
 call and ring volume, allow volume selection*)
on get_Volume()
	try -- check if the host is ringing, if so answer and if configured set conference light on
		get_actionScript("xStatus Call Status")
		set r to do shell script "expect <<<" & quoted form of expectScript
		if r contains "Ringing" then
			if AutoAnswer is "" then
				get_PreReqs("AutoAnswer")
			else if AutoAnswer is "Yes" then
				set answer to "accept"
				get_actionScript("xCommand Call " & answer)
				do shell script "expect <<<" & quoted form of expectScript
				set state to "1"
				set theVolume to theCallVolume
				set callStatus to "1"
				return get_actionScript("xCommand Audio Volume Set Level:" & theVolume)
			end if
		else if r contains "Connected" or r contains "Dialling" or r contains "Connecting" then
			if r contains "fingerprint" then -- avoid turning conference light on with first run accepting the ssh fingerprint
				set state to "0"
			else
				set state to "1"
			end if

		else -- if not ringing or in some connection state turn the conference light off
			set callStatus to "0"
			set state to "0"
		end if
	on error
		display dialog "Something Went Wrong"
	end try
	try -- get the current volume of the host
		get_actionScript("xStatus Audio Volume")
		set r to do shell script "expect <<<" & quoted form of expectScript & "| grep \"Volume:\""
		set currVolume to r as text
		try
			set AppleScript's text item delimiters to ":"
			set currVolume to (word 4 of paragraph 1 of currVolume) as text
			set AppleScript's text item delimiters to ""
		end try
	on error
		set currVolume to "theMuteVolume"
	end try
	--display dialog "The call status is: " & callStatus
	-- set default button based on current host volume
	if callStatus is "0" then
		if currVolume is less than theCallVolume then
			set b to display dialog "Set Deskpro Volume Level" buttons {"Mute", "In Call", "Ring"} default button "In Call" giving up after 5 with title name of me
		else if currVolume is greater than theRingVolume then
			set b to display dialog "Set Deskpro Volume Level" buttons {"Mute", "In Call", "Ring"} default button "Ring" giving up after 5 with title name of me
		end if
		if button returned of b is "Ring" then
			set theVolume to theRingVolume
		else if button returned of b is "Mute" then
			set theVolume to theMuteVolume
		else if button returned of b is "In Call" then
			set theVolume to theCallVolume
		else
			error number -128
		end if
	else if callStatus is "1" then
		if currVolume is less than theCallVolume then
			set b to display dialog "Set Deskpro Volume Level" buttons {"Mute", "UnMute", "Disconnect"} default button "UnMute" giving up after 5 with title name of me
		else if currVolume is greater than theRingVolume then
			set b to display dialog "Set Deskpro Volume Level" buttons {"Mute", "UnMute", "Disconnect"} default button "Mute" giving up after 5 with title name of me
		end if
		if button returned of b is "UnMute" then
			set theVolume to theCallVolume
		else if button returned of b is "Mute" then
			set theVolume to theMuteVolume
		else if button returned of b is "Disconnect" then
			set answer to "disconnect"
			get_actionScript("xCommand Call " & answer)
			do shell script "expect <<<" & quoted form of expectScript
			set state to "0"
			set theVolume to theRingVolume
			set callStatus to "0"
			return get_actionScript("xCommand Audio Volume Set Level:" & theVolume)
		else
			error number -128
		end if
	end if
	get_actionScript("xCommand Audio Volume Set Level:" & theVolume) -- set the host volume
	-- myPrefs("set", "currVolume")
end get_Volume

-- Verify that a thePwd does not contain any characters that will break the script
on pwdOK(thePwd)
	set PWDchars to characters of thePwd
	repeat with ch in PWDchars
		if ch is in BadPWDchars then
			return false
		end if
	end repeat
	return true
end pwdOK

(* Call this hanlder to store or clear User Preferences set in <prefsName>.plist file *)
on myPrefs(action, theKeyValue)
	if action is "set" and theKeyValue is "yes" then
		do shell script "defaults write com.cisco." & quoted form of prefsName & " saved" & " '" & "yes" & "'"
		do shell script "security add-generic-password -a " & quoted form of prefsName & "  -w " & quoted form of thePwd & " -j 'Used by Applescript Deskpro Volume' -s" & quoted form of prefsName & "." & theUser
	else if action is "set" and theKeyValue is "no" then
		do shell script "defaults write com.cisco." & quoted form of prefsName & " saved" & " '" & "no" & "'"
		--else if action is "set" and theKeyValue is "create" then
		--do shell script "security add-generic-password -a " & quoted form of prefsName & "  -w " & quoted form of thePwd & " -j 'Used by Applescript Deskpro Volume' -s" & quoted form of prefsName & "." & theUser
	else if action is "set" and theKeyValue is "delete" then
		do shell script "security delete-generic-password -a " & quoted form of prefsName
	else if action is "reset" and theKeyValue is "clear" then
		try
			do shell script "defaults delete com.cisco." & quoted form of prefsName & " saved"
		end try
		try
			do shell script "security delete-generic-password -a " & quoted form of prefsName
		end try
	else if action is "reset" and theKeyValue is "sshreset" then
		try
			do shell script "defaults delete com.cisco." & quoted form of prefsName & " sshfingerprint"
		end try
	else if action is "reset" and theKeyValue is "reset" then
		try
			do shell script "defaults delete com.cisco." & quoted form of prefsName
			do shell script "security delete-generic-password -a " & quoted form of prefsName
		end try
	end if
end myPrefs

(* On first run it will check for the preference com.cisco.<prefsName> sshfingerprint. If it exist, the script
assumes you have connected at least once to the deskpro with ssh and accepted the fingerprint. If it
does not exist, the script runs get_PreReqa("First Run") to accept the fingerprint which will ensure
you have the entry in your .ssh/known_hosts file *)
on get_PreReqs(action)
	(*if action is "ssh" then
		try
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " firstrun"
			set b to result
		on error
			display dialog "The script requires connecting to the host via ssh. You chose to not auto accept the ssh fingerprint. Please ensure you have an entry in your known_hosts file for this host." buttons {"Cancel"} cancel button "Cancel"
		end try
	end if
	*)
	if action is "sshfingerprint" then
		try -- check if first run has been accomplished
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " sshfingerprint"
			set b to result
			if b is "no" then
				get_actionScript("no")
			end if
		on error -- this is the first run ask user to accept the ssh fingerprint from the host
			set b to display dialog "Do you want to accept the SSH fingerprint from " & theHost & return & return & "This is only asked on the first run." & return & return & "The script requires connecting to the host via ssh. You if you choose to not auto accept the ssh fingerprint, please ensure you have an entry in your known_hosts file for this host." buttons {"Yes", "No"} default button "Yes" with title name of me
			if button returned of b is "Yes" then
				do shell script "defaults write com.cisco." & quoted form of prefsName & " sshfingerprint" & " 'yes'"
				do shell script "defaults write com.cisco." & quoted form of prefsName & " firstrun" & " '0'"
				get_User("get")
				--get_actionScript("yes")
				set acceptCertScript to "set timeout 20
spawn ssh " & theUser & "@" & theHost & "
expect {
   \"fingerprint\" {
       send \"yes
\"
       exp_continue
   }
   \"Password:\" {
       send \"" & thePwd & "\\r\"
       exp_continue
   }
    \"Login successful\" {
       send \"" & theEnd & "\\r\"
       exp_continue
   }
}"
				do shell script "expect <<<" & quoted form of acceptCertScript
			else if button returned of b is "No" then
				do shell script "defaults write com.cisco." & quoted form of prefsName & " sshfingerprint" & " 'no'"
				do shell script "defaults write com.cisco." & quoted form of prefsName & " firstrun" & " '0'"
				display dialog "The script requires connecting to the host via ssh. You chose to not auto accept the ssh fingerprint. Please ensure you have an entry in your known_hosts file for this host." buttons {"Cancel"} cancel button "Cancel" with title name of me
			else
				error number -128
			end if
		end try
		if b is "no" then
			set theCmd to ""
			set b to display dialog "The script requires connecting to the host via ssh. You chose to not auto accept the ssh fingerprint. Please ensure you have an entry in your known_hosts file for this host." buttons {"Clear Preference", "Cancel"} cancel button "Cancel" with title name of me
			if button returned of b is "Clear Preference" then
				myPrefs("reset", "sshreset")
			end if
		end if
	else if action is "getPrefs" then
		(* check the preferences file to see if the options are set and get thier values. If no previous setting prompt user for input *)
		try -- check to see if a hostname has been previously saved and use it
			do shell script "defaults read com.cisco." & quoted form of prefsName & " hostname"
			set theHost to result
		on error -- no previous username entry so ask user for it
			set b to display dialog ("What is your Deskpro IP address or Hostname?") default answer "" with title name of me
			set theHost to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " hostname" & " '" & theHost & "'"
		end try
		try -- check to see if a username has been previously saved
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " username"
			set theUser to result
		on error -- no previous username entry  so ask user for it
			set b to display dialog ("What is your Deskpro Username?") default answer "" with title name of me
			set theUser to text returned of b
			do shell script "defaults write com.cisco." & quoted form of prefsName & " username" & " '" & theUser & "'"
		end try
		try -- check to see if a base64 combo has been previously saved
			set theAuth to do shell script "security find-generic-password -wl " & quoted form of prefsName & "." & theUser & ".base64_auth"
		on error
			set theAuth to ""
		end try
		if (length of theAuth is 0) then -- not already on the KeyChain.    Prompt for it and add..
			set theAuth to display dialog ("What is your Deskpro Username:Password base64url encoded string?") default answer "" with title name of me with hidden answer
			set theAuth to text returned of theAuth
			do shell script "security add-generic-password -a " & quoted form of prefsName & "  -w " & quoted form of theAuth & " -j 'Used by Applescript Deskpro Volume' -s" & quoted form of prefsName & "." & theUser & ".base64_auth"
		end if

		try -- check to see if an auto answer option was selected
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " AutoAnswer"
			set AutoAnswer to result
		on error -- no previous auto answer selection so aks user for it
			set b to display dialog ("Do you want the script to be able to answer incoming calls?") buttons {"Yes", "No"} default button "Yes" with title name of me
			set AutoAnswer to result
			do shell script "defaults write com.cisco." & quoted form of prefsName & " AutoAnswer" & " 'Yes'"
		end try

		try -- check to see if TP-Link Control option exists
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " tplink"
			set tplink to result
		on error -- no previous TP-Link selection so ask user for it
			set c to display dialog ("Do you want the script to control a TP-Link Status Light?") buttons {"Yes", "No"} default button "Yes" with title name of me
			if button returned of c is "Yes" then
				set tplink to "1"
				do shell script "defaults write com.cisco." & quoted form of prefsName & " tplink" & " '1'"
				set tplink_script to "TPLink Plug Control For DVU.scpt"
				do shell script "defaults write com.cisco." & quoted form of prefsName & " tplink_script" & " 'TPLink Plug Control For DVU.scpt'"
				set tplink_script to ((path to scripts folder as text) & tplink_script) as alias
			else
				do shell script "defaults write com.cisco." & quoted form of prefsName & " tplink" & " '0'"
				set tplink to "0"
			end if
		end try

		try
			set b to do shell script "defaults read com.cisco." & quoted form of prefsName & " tplink_script"
			set tplink_script to result
			set tplink_script to ((path to scripts folder as text) & tplink_script) as alias
		on error
			display dialog "what went wrong?"
		end try
		get_PreReqs("sshfingerprint")
	end if
end get_PreReqs



(* USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND *)
set mgStop to do shell script mgRightNow
set mgRunTime to mgStop - mgStart
display dialog "This took " & mgRunTime & " seconds." & return & "that's " & (round (mgRunTime * 1000)) & " milliseconds."

