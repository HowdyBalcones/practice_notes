--IterateAssignmentProperty.applescript
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
		--<fragment>
		tell myDocument
			set myAssignement to assignment 1
			tell myAssignement
				set myuserName to user name
				set myFilePath to file path
				set myDocPath to document path
				set myFramecolor to frame color
				set myincludeLinksWhenPackage to include links when package
				
				-- Export options for assignment files.
				-- AssignmentExportOptions.ASSIGNED_SPREADS Exports only spreads with assigned frames
				-- AssignmentExportOptions.EMPTY_FRAMES  Exports frames but does not export content
				-- AssignmentExportOptions.EVERYTHING   Exports the entire document.
				set myExportOptions to export options
			end tell
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
