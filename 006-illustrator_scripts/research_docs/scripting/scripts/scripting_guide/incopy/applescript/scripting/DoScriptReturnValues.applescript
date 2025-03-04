--DoScriptReturnValues.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
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
	tell application "Adobe InCopy 2024"
		--Create a string to be run as an AppleScript.
		set myAppleScript to "tell application \"Adobe InCopy 2024\"" & return
		set myAppleScript to myAppleScript & "tell script args" & return
		set myAppleScript to myAppleScript & "set value name \"ScriptArgumentA\" value \"This is the first AppleScript script argument value.\"" & return
		set myAppleScript to myAppleScript & "set value name \"ScriptArgumentB\" value \"This is the second AppleScript script argument value.\"" & return
		set myAppleScript to myAppleScript & "end tell" & return
		set myAppleScript to myAppleScript & "end tell"
		--Run the AppleScript string.
		do script myAppleScript language applescript language
		--Retrieve the script argument values set by the script.
		tell script args
			set myScriptArgumentA to get value name "ScriptArgumentA"
			set myScriptArgumentB to get value name "ScriptArgumentB"
		end tell
		--Display the script argument values in a dialog box.
		display dialog "ScriptArgumentA: " & myScriptArgumentA & return & "ScriptArgumentB: " & myScriptArgumentB
		--Create a string to be run as a JavaScript.
		set myJavaScript to "app.scriptArgs.setValue(\"ScriptArgumentA\", \"This is the first JavaScript script argument value.\");" & return
		set myJavaScript to myJavaScript & "app.scriptArgs.setValue(\"ScriptArgumentB\", \"This is the second JavaScript script argument value.\");" & return
		--Run the JavaScript string.
		do script myJavaScript language javascript
		--Retrieve the script argument values set by the script.
		tell script args
			set myScriptArgumentA to get value name "ScriptArgumentA"
			set myScriptArgumentB to get value name "ScriptArgumentB"
		end tell
		--Display the script argument values in a dialog box.
		display dialog "ScriptArgumentA: " & myScriptArgumentA & return & "ScriptArgumentB: " & myScriptArgumentB
	end tell
end mySnippet
on myTeardown()
end myTeardown

