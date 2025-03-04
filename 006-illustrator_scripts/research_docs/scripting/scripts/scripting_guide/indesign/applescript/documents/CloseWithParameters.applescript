--CloseDocument.applescript
--An InDesign AppleScript
--
--Close the active document with parameters.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create and save a new document.
		set myDocument to make document
		set myTempFolder to path to temporary items folder as string
		tell myDocument
			--Refresh object reference invalidated by save.
			set myDocument to save to myTempFolder & "OpenDocumentExample.indd"
		end tell
		--Modify the document to force script to ask to save.
		tell myDocument to make page
		tell document preferences of myDocument
			set page orientation to landscape
		end tell
	end tell
end mySetup
on mySnippet()
	--![Close a document with parameters.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--Close the active document with parameters:
		--Use "saving yes" to save the document,
		--or "saving no"  to close the document without saving, 
		--or "saving ask" to display a prompt.
		--If you use "saving yes", you'll need to provide a reference 
		--to a file to save to in the second parameter.
		--If the file has never been saved (it's an untitled file), 
		--display a prompt. 
		if saved of myDocument is not equal to true then
			close myDocument saving ask
			--Or, to save to a specific file name 
			--(you'll have to fill in your own file path in the variable "myPath"):
			--close myDocument saving yes saving in myPath
		else
			--If the file has already been saved to a file, save it.
			close myDocument saving yes
		end if
	end tell
	--![Close a document with parameters.]
end mySnippet
on myTeardown()
end myTeardown
