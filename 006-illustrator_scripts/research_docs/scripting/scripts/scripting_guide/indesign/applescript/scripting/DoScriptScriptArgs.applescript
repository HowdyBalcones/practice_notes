--DoScriptReturnValues.applescript
--An InDesign AppleScript
--
--Shows how to get values back from a script run using
--the do script command.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Script args from do script.]
		set nameA to "ScriptArgumentA"
		set nameB to "ScriptArgumentB"
		set nAc to nameA & ": "
		set nBc to nameB & ": "
		--Create a string to be run as an AppleScript.
		set p1 to "tell application \"Adobe InDesign 2024\"" & return
		set p2 to "tell script args" & return
		set p3 to "set value name \"ScriptArgumentA\" value "
		set p4 to "\"This is the first AppleScript script argument value.\""
		set p5 to "set value name \"ScriptArgumentB\" value "
		set p6 to "\"This is the second AppleScript script argument value.\""
		set p7 to "end tell" & return
		set p8 to "end tell"
		set myAppleScript to p1 & p2 & p3 & p4 & return & p5 & p6 & return & p7 & p8
		--Run the AppleScript string.
		do script myAppleScript language applescript language
		--Retrieve the script argument values set by the script.
		tell script args
			set myScriptArgumentA to get value name nameA
			set myScriptArgumentB to get value name nameB
		end tell
		--Display the script argument values in a dialog box.
		display dialog nAc & myScriptArgumentA & return & nBc & myScriptArgumentB
		--Create a string to be run as a JavaScript.
		set p1 to "app.scriptArgs.setValue(\"ScriptArgumentA\", "
		set p2 to "\"This is the first JavaScript script argument value.\");" & return
		set p3 to "app.scriptArgs.setValue(\"ScriptArgumentB\", "
		set p4 to "\"This is the second JavaScript script argument value.\");" & return
		set myJavaScript to p1 & p2 & p3 & p4
		--Run the JavaScript string.
		do script myJavaScript language javascript
		--Retrieve the script argument values set by the script.
		tell script args
			set myScriptArgumentA to get value name nameA
			set myScriptArgumentB to get value name nameB
		end tell
		--Display the script argument values in a dialog box.
		display dialog nAc & myScriptArgumentA & return & nBc & myScriptArgumentB
		--![Script args from do script.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
