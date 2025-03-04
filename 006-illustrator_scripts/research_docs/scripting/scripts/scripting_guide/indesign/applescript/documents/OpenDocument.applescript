--OpenDocument.applescript
--An InDesign AppleScript
--
--Opens the specified file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	--Creates a new document.
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "OpenDocumentExample.indd"
		tell myDocument to save to myFile
		close document 1
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "OpenDocumentExample.indd"
		--![Open a document.]
		--Opens an existing document. You'll have to fill in your own file path
		--in the variable "myFile".
		set myDocument to open myFile
		--![Open a document.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
