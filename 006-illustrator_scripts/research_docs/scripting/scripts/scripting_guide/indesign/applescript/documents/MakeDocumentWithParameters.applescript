--MakeDocumentWithParameters.applescript
--An InDesign AppleScript
--
--Creates a new document without showing the document window.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
end mySetup
--</setup>
--<snippet>
to mySnippet()
	--![Create a document with parameters.]
	--Creates a new document without showing the document window.
	--The "showing window" parameter controls the visibility of the document.
	--Hidden documents are not minimized, and will remain invisible until
	--you tell the document to create a new window.
	tell application "Adobe InDesign 2024"
		set myDocument to make document with properties {showing window:false}
		--To show the window:
		tell myDocument
			set myWindow to make window
		end tell
	end tell
	--![Create a document with parameters.]
end mySnippet
--</snippet>
--<teardown>
to myTeardown()
end myTeardown
--</teardown>



