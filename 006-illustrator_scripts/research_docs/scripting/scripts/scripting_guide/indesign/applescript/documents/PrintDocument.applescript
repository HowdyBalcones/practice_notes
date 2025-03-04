--PrintDocument.applescript
--An InDesign AppleScript
--
--Prints the active document using the current print settings.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--Prints the active document using the current print settings.
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell print preferences of myDocument
			--The doucment is blank, so have to set 
			--print preference
			set print blank pages to true
		end tell
		--![Print document.]
		--The print statement has two optional varients:
		--without print dialog -- do not display the Print dialog box.
		--using "presetName" -- use a named printer preset.
		--The following line prints the document using the default
		--settings without displaying the Print dialog box.
		print myDocument without print dialog
		--![Print document.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
