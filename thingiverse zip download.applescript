(* Applescript to fix broken "zip" download from Thingiverse. 
OS Version: Mac OS X 12.1
Chrome Version: 98.0.4758.102 (Official Build) (x86_64)
Safari Version: 15.2 (17612.3.6.1.6)

Your milage may vary! 

Script will download the zip file of a "thing" from Thingiverse. Some logic is built into the script to determine if you are actually on Thingiverse and what page you are on for the "thing". It will set the end of the "thing" URL to "/zip" in order to download the zip file of all thing files. 

HOW TO USE: 

I use a launcher called FastScripts (there is a free version available) to launch the script with a keyboard shortcut. Simply open the thing URL in your browser (Chrome or Safari), hit your keyboard shortcut assigned in FastScripts. The script will launch and download the thing files. 


Edit the Applescript to indicate your default/preferred browser
*)

(* OLD METHOD OF SETTING DEFAULT BROWSER
(* remove the "--" at the beginning of the below line to use Google Chrome. Make sure the Safari line below is commented out with "--"  *)
-- set defaultbrowser to "Google Chrome"

(* remove the "--" at the beginning of the below line to use Safari. Make sure there is a "--" at the beginning of the above Google Chrome line. *)
-- set defaultbrowser to "Safari" 
*)

(* NEW METHOD TO GET DEFAULT BROWSER *)
set defaultBrowser to do shell script "defaults read \\
    ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure \\
    | awk -F'\"' '/http;/{print window[(NR)-1]}{window[NR]=$2}'"

if defaultBrowser is "" or defaultBrowser contains "safari" then
	--  # The default Browser is Safari.
	set defaultBrowser to "Safari"
	--  # Your code goes here.
else if defaultBrowser contains "chrome" then
	--  # The default Browser is Google Chrome.
	set defaultBrowser to "Google Chrome"
	--  # Your code goes here.
else if defaultBrowser contains "firefox" then
	--  # The default Browser is Firefox.
	set defaultBrowser to "Firefox"
	--  # Your code goes here.
else
	set defaultBrowser to "Other"
	--  # Your code goes here.
end if
(* END OF NEW METHOD TO GET DEFAULT BROWSER *)

if defaultBrowser = "Google Chrome" then
	tell application "Google Chrome"
		set theURL to URL of active tab of window 1
	end tell
else if defaultBrowser = "Safari" then
	tell application "Safari"
		set theURL to URL of current tab of window 1
	end tell
else if defaultBrowser = "firefox" then
	tell application "Firefox" to activate
	tell application "System Events"
		keystroke "l" using command down
		keystroke "c" using command down
	end tell
	delay 0.5
	set theURL to the clipboard
	--	return
end if
if theURL does not contain "thingiverse.com" then
	display dialog "This doesn't look like a Thingiverse Download Request, exiting now!" giving up after 2
	return
else
	set newURL to {""}
	if theURL contains "thingiverse.com/thing:" then
		set lastWord to last word of theURL as string
		if lastWord is not "files" and lastWord is not "comments" and lastWord is not "makes" and lastWord is not "remixes" and lastWord is not "apps" then
			set end of newURL to theURL & "/zip"
		else
			set newURL to {"http://"}
			repeat with i in words of theURL
				if i contains "http" then
					set newURL to newURL
				else
					if i contains "thing" and i does not contain "thingiverse" then
						set end of newURL to i & ":" as string
					else if i contains "files" or i contains "comments" or i contains "makes" or i contains "remixes" or i contains "apps" then
						set i to "zip"
						set the end of newURL to i as string
					else
						set the end of newURL to i & "/" as string
					end if
				end if
			end repeat
		end if
	end if
end if
set newURL to newURL as string

if defaultBrowser is "Google Chrome" then
	tell application "Google Chrome"
		open location newURL
	end tell
else if defaultBrowser is "Safari" then
	tell application "Safari"
		tell window 1
			set URL of (make new tab) to newURL
			set current tab to last tab
			delay 5
			close current tab
		end tell
	end tell
else if defaultBrowser is "Firefox" then
	tell application "Firefox"
		open location newURL
		delay 10
		tell application "System Events"
			keystroke "w" using command down
		end tell
	end tell
	
end if

