--CreateGuides.applescript
--An InDesign AppleScript
--
--Add a series of guides using the create guides command.
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024" to make document
end mySetup
on mySnippet()
	--Add a series of guides using the create guides command.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Create guides.]
		--Given a document "myDocument"...
		set myLayer to layer 1 of myDocument
		tell spread 1 of myDocument
			--Parameters (all optional): row count, column count, row gutter,
			--column gutter, guide color, fit margins, remove existing, layer.
			--Note that the createGuides method does not take an RGB array for
			--the guide color parameter.
			create guides number of rows 4 number of columns 4 row gutter "1p" column gutter "1p" guide color gray with fit margins and remove existing
		end tell
		--![Create guides.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
