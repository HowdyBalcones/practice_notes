--CloseAll.applescript
--An InDesign AppleScript
--
--Close all open documents without saving.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
		make document
		make document
	end tell
	display dialog ("Three documents created")
end mySetup
on mySnippet()
	--Close all open documents without saving.
	--![Close all documents.]
	tell application "Adobe InDesign 2024"
		tell documents to close saving no
	end tell
	--![Close all documents.]
end mySnippet
on myTeardown()
end myTeardown

