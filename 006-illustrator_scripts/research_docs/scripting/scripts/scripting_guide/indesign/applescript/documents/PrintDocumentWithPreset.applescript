--PrintDocument.applescript
--An InDesign AppleScript
--
--Prints the active document using the specified printer preset.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		try
			set myPrinterPreset to printer preset "myPrinterPreset"
		on error
			set myPrinterPreset to make printer preset with properties {name:"myPrinterPreset"}
		end try
		set myDocument to make document
		tell myDocument
			set facing pages of document preferences to false
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			--Create a single-page master spread.
			tell master spread 1
				repeat while (count of pages) > 1
					delete page -1
				end repeat
				tell page 1
					set myTextFrame to make text frame with properties {geometric bounds:{0, 0, myPageHeight, myPageWidth}, contents:auto page number}
				end tell
				set vertical justification of text frame preferences of myTextFrame to center align
				set justification of paragraph 1 of myTextFrame to center align
				set point size of character 1 of myTextFrame to 72
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	--Prints the active document using the specified printer preset.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Print with preset.]
		--Given a document "myDocument" and a printer preset named "myPrinterPreset"...
		set myPrinterPreset to printer preset "myPrinterPreset"
		print myDocument using myPrinterPreset without print dialog
		--![Print with preset.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
