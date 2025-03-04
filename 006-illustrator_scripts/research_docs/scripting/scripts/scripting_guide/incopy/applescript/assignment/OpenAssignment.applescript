--OpenAssignment.applescript
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
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "a.icma"
		--<fragment>
		--Opens an existing document. You'll have to fill in your own file path
		--in the variable "myFile".
		set myDocument to open myFile
		tell myDocument
			set myAssignement to assignment 1
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
