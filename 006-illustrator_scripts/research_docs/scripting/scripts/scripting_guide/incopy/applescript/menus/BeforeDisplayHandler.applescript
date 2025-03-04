--BeforeDisplayHandler.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Script called by the BeforeDisplay tutorial script.
tell application "Adobe InCopy 2024"
	try
		set mySampleScriptAction to script menu action "Display Message"
		set mySelection to selection
		if (count mySelection) > 0 then
			set enabled of mySampleScriptAction to true
		else
			set enabled of mySampleScriptAction to false
		end if
	on error
		alert("Script menu action did not exist.")
	end try
end tell
