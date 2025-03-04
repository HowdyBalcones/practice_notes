--GetAssignment.applescript
--An InCopy AppleScript
--
--Open an InCopy dcoument.

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
	  --<fragment>
		set myDocument to document 1
		tell myDocument
		     set myAssignement to assignment 1
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
