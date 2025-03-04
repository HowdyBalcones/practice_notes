--DoScriptParameters.applescript
--An InDesign AppleScript
--
--Shows how to send parameters to a script called using
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
	--![Sending parameters to do script.]
	tell application "Adobe InDesign 2024"
		--Create a list of parameters.
		set myParameters to {"Hello from do script", "Your message here."}
		--Create a JavaScript as a string.
		set myJavaScript to "alert(\"First argument: \" + arguments[0] + "
		set myJavaScript to myJavaScript & "\"\\rSecond argument: \" + arguments[1])"
		--Run the JavaScript using the do script command.
		do script myJavaScript language javascript with arguments myParameters
		--Create an AppleScript as a string.
		set myAppleScript to "tell application \"Adobe InDesign 2024\"" & return
		set myAppleScript to myAppleScript & "tell application \"Adobe InDesign 2024\"" & return
		set myAppleScript to myAppleScript & "display dialog ("
		set myAppleScript to myAppleScript & "\"First argument: \" & item 1 of arguments & return"
		set myAppleScript to myAppleScript & "& \"Second argument: \" & item 2 of arguments)" & return
		set myAppleScript to myAppleScript & "end tell" & return
		set myAppleScript to myAppleScript & "end tell" & return
		--Run the AppleScript using the do script command.
		do script myAppleScript language applescript language with arguments myParameters
	end tell
	--![Sending parameters to do script.]
end mySnippet
on myTeardown()
end myTeardown
