--PackageAssignment.applescripttell application "Adobe InCopy 2024"
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
		set myDocument to document 1
		tell myDocument
			set myAssignement to assignment 1
			tell myAssignement
				if packaged is false then
					set myDesktopFolder to path to desktop as string
					set myFile to myDesktopFolder & "b.icap"
					--create package myFile with FORWARD_PACKAGE
				end if
			end tell
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown

