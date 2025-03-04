--BeforeDisplayHandler.applescript
--An InDesign AppleScript
--
--Provides a "beforeDisplay" event handler for the BeforeDisplay.applescript
--tutorial script. If one or more items are selected, enable the menu item. 

--![Before display handler.]
tell application "Adobe InDesign 2024"
	try
		set mySampleScriptAction to script menu action "Display Message"
		set mySelection to selection
		if (count mySelection) > 0 then
			set enabled of mySampleScriptAction to true
		else
			set enabled of mySampleScriptAction to false
		end if
	on error
		display alert ("Script menu action did not exist.")
	end try
end tell
--![Before display handler.]

