#@osa-lang:AppleScript
(* Applescript to fix broken "zip" download from Thingiverse.
OS Version: Mac OS X 12.1
Chrome Version: 98.0.4758.102 (Official Build) (x86_64)
Safari Version: 15.2 (17612.3.6.1.6)

Your milage may vary!

Script will download the zip file of a "thing" from Thingiverse. Some logic is built into the script to determine if you are actually on Thingiverse and what page you are on for the "thing". It will set the end of the "thing" URL to "/zip" in order to download the zip file of all thing files.

HOW TO USE:

I use a launcher called FastScripts (there is a free version available) to launch the script with a keyboard shortcut. Simply open the thing URL in your browser (Chrome or Safari), hit your keyboard shortcut assigned in FastScripts. The script will launch and download the thing files.
*)
property theCleanURL : ""
property theURL : ""
property zipURL : {}
property badURLWords : {"apps", "comments", "files", "makes", "remixes"}

(* GET DEFAULT BROWSER *)
set defaultBrowser to do shell script "defaults read \\
    ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure \\
    | awk -F'\"' '/http;/{print window[(NR)-1]}{window[NR]=$2}'"
if defaultBrowser is "" or defaultBrowser contains "safari" then
	set defaultBrowser to "Safari"
	tell application "Safari"
		set theRawURL to URL of current tab of window 1
	end tell

else if defaultBrowser contains "chrome" then
	set defaultBrowser to "Google Chrome"
	tell application "Google Chrome"
		set theRawURL to URL of active tab of window 1
	end tell

else if defaultBrowser contains "firefox" then
	set defaultBrowser to "Firefox"
	tell application "Firefox" to activate
	tell application "System Events"
		keystroke "l" using command down
		keystroke "c" using command down
	end tell
	delay 0.5
	set theRawURL to the clipboard
else
	set defaultBrowser to result
	display dialog "Default browser " & defaultBrowser & " not supported, exiting" giving up after 2
end if
(* END GET DEFAULT BROWSER *)

if theRawURL does not contain "thingiverse.com" then
	display dialog "This doesn't look like a Thingiverse Download Request, exiting now!" giving up after 2
	return
else
	if theRawURL contains "?" then
		cleanURL(theRawURL)
		mkZipURL(theCleanURL)
	else
		mkZipURL(theRawURL)
	end if
end if

if defaultBrowser is "Google Chrome" then
	tell application "Google Chrome"
		open location zipURL
	end tell
else if defaultBrowser is "Safari" then
	tell application "Safari"
		tell window 1
			set URL of (make new tab) to zipURL
			set current tab to last tab
			delay 5
			close current tab
		end tell
	end tell
else if defaultBrowser is "Firefox" then
	tell application "Firefox"
		open location zipURL
		delay 10
		tell application "System Events"
			keystroke "w" using command down
		end tell
	end tell
end if

on cleanURL(theRawURL)
	set theCleanURL to ""
	repeat with a from 1 to length of theRawURL
		set theCurrentCharacter to character a of theRawURL
		if theCurrentCharacter is not "?" then
			set theCleanURL to theCleanURL & theCurrentCharacter as string
		else if theCurrentCharacter is "?" then
			return theCleanURL
		end if
	end repeat
	return theCleanURL
end cleanURL

on mkZipURL(theURL)
	if theURL contains "thingiverse.com/thing:" then
		set lastWord to last word of theURL as string
		if badURLWords contains lastWord then
			set theURL to words of theURL
			set last item of theURL to "zip"
			set zipURL to {"http://"}
			repeat with i in items of theURL
				if i contains "http" then
					set zipURL to zipURL
				else
					if i contains "thing" and i does not contain "thingiverse" then
						set end of zipURL to i & ":" as string
					else if i contains "zip" then
						set the end of zipURL to i as string
					else
						set the end of zipURL to i & "/" as string
					end if
				end if
			end repeat
		else
			set zipURL to theURL & "/zip"
		end if

	end if
	set zipURL to zipURL as string
end mkZipURL
