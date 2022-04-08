#@osa-lang:AppleScript

set kasacontrol to (path to scripts folder as text) & "TPLink Plug Control For DVU.scpt" as alias
global kasacontrol
property tplink_light : ""

set b to ""
-- display dialog tplink_light
if tplink_light is "0" or tplink_light is "" then
	set b to display dialog "TP-Link Conference Light Control" buttons {"On", "Off"} default button "On" with title "TP-Link Conference Light"

else if tplink_light is "1" then
	set b to display dialog "TP-Link Conference Light Control" buttons {"On", "Off"} default button "Off" with title "TP-Link Conference Light"

end if

if button returned of b is "Off" then
	set state to "0"
	set tplink_light to "0"
else if button returned of b is "On" then
	set state to "1"
	set tplink_light to "1"
end if

set tplink_script to (path to scripts folder as text) & "TPLink Plug Control For DVU.scpt" as alias

run script tplink_script with parameters {state}