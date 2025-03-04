--SaveDocumentAs.applescript
--An InDesign AppleScript
--
--Shows how to save a document to a different file name.
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocumentAs.indd"
		tell myDocument
			save to myFile
		end tell
	end tell
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		--![Save document as.]
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SaveDocumentAsDuplicate.indd"
		tell document 1 to save to myFile
		--![Save document as.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
