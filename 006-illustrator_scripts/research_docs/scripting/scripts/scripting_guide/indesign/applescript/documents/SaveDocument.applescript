--SaveDocument.applescript
--An InDesign AppleScript
--
--If the document has been changed since it was last saved, save it.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocument.indd"
		set myDocument to make document
		save myDocument to myFile
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocument.indd"
		set myDocument to open myFile
		tell page 1 of myDocument
			make rectangle
		end tell
		--![Save a document.]
		--Given a document myDocument...
		--If the document has been changed since it was last saved, save it.
		--If the file is untitled, InDesign will display the Save dialog box.
		if modified of myDocument is true then
			tell myDocument to save
		end if
		--![Save a document.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

