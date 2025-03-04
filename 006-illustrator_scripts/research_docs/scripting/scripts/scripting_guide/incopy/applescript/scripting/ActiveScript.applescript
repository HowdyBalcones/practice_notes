--ActiveScript.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
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
	tell application "Adobe InCopy 2024"
		set myScript to active script
		display dialog ("The current script is: " & myScript)
		tell application "Finder"
			set myFile to file myScript
			set myParentFolder to container of myFile
		end tell
		display dialog ("The folder containing the active script is: " & myParentFolder)
	end tell
end mySnippet
on myTeardown()
end myTeardown
