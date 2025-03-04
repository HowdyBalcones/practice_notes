--CloseDocument.applescript
--An InDesign AppleScript
--
--Close the active document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Closes the active document.
	--![Close a document.]
	tell application "Adobe InDesign 2024"
		close document 1
	end tell
	--![Close a document.]
end mySnippet
on myTeardown()
end myTeardown
