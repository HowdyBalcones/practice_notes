--OpenDocumentInBackground.applescript
--An InDesign AppleScript
--
--Opens the specified file without showing the document window.
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
		--![Open a document in background.]
		--Opens an existing document. You'll have to fill in your own file path
		--in the variable "myFile".
		set myDocument to open myFile without showing window
		--At this point, you can do things with the document without showing the
		--document window. This can speed up many scripting
		--operations, and makes it possible for a script to operate
		--on a file in the background.
		display dialog ("Document is open but not visible")
		--Show the document.
		tell myDocument to make window
		--![Open a document in background.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
