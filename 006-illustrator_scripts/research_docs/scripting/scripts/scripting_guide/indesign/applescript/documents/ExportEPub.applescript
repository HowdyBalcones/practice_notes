--ExportEPub.applescript
--An InDesign AppleScript
--
--Exports a document to an EPub file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportEPub.indd"
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			--Set the ruler origin to page origin.
			set ruler origin to page origin
		end tell
		
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
			--Set the bounds of the text frame.
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
			--Enter text in the text frame.
			set contents of myTextFrame to "This is some example text."
		end tell
		tell myDocument
			set myDocument to save to myFile
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ExportEPub.epub"
		set myDocument to document 1
		--![Export to EPub.]
		tell myDocument
			export format EPUB to myFile without showing options
		end tell
		--![Export to EPub.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
