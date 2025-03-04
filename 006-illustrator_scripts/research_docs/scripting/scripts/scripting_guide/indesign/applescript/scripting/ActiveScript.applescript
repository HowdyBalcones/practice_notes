--ActiveScript.applescript
--An InDesign AppleScript
--
--Demonstrates the use of the active script property.
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
		--![Getting the Current Script.]
		set myScript to active script
		display dialog ("The current script is: " & myScript)
		tell application "Finder"
			set myFile to file myScript
			set myParentFolder to container of myFile
		end tell
		display dialog ("The folder containing the active script is: " & myParentFolder)
		--![Getting the Current Script.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
