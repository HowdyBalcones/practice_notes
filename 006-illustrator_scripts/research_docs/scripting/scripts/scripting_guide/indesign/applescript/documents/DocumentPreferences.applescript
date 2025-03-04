--DocumentPreferences.applescript
--An InDesign AppleScript
--
--Use the documentPreferences object to change the page height, width,
--orientation, and the number of pages of a new document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Use the documentPreferences object to change the page height, width,
	--orientation, and the number of pages of a new document.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Defining page size and document length.]
		--Given a document "myDocument"...
		tell document preferences of myDocument
			set page height to "800pt"
			set page width to "600pt"
			set page orientation to landscape
			set pages per document to 16
		end tell
		--![Defining page size and document length.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
