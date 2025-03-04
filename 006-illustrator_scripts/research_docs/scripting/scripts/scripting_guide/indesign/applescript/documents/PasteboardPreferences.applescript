--PasteboardPreferences.applescript
--An InDesign AppleScript
--
--Change the size and preview color of the pasteboard.
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
	--Change the size and preview color of the pasteboard.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Change pasteboard preferences.]
		--Given a document "myDocument"...
		tell pasteboard preferences of myDocument
			--You can use either a number or a measurement string
			--to set minimum horizontal and vertical pasteboard margins
			set pasteboard margins to {"12p", "15p"}
			--You can set the preview background color (which you'll only see
			--in Preview mode) to any of the predefined UIColor constants...
			set preview background color to gray
			--...or you can specify an array of RGB values
			--   (with values from 0 to 255)
			set preview background color to {192, 192, 192}
		end tell
		--![Change pasteboard preferences.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
