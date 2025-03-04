--FontCollections.applescript
--An InDesign AppleScript
--
--Shows the difference between the fonts collection of the application
--and the fonts collection of a document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Font collections.]
		set myApplicationFonts to the name of every font
		set myDocument to active document
		tell myDocument
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
			end tell
			set myStory to parent story of myTextFrame
			set myDocumentFonts to name of every font
		end tell
		set myString to "Document Fonts:" & return
		repeat with myCounter from 1 to (count myDocumentFonts)
			set myString to myString & (item myCounter) of myDocumentFonts & return
		end repeat
		set myString to myString & return & "Application Fonts:" & return
		repeat with myCounter from 1 to (count myApplicationFonts)
			set myString to myString & (item myCounter) of myApplicationFonts & return
		end repeat
		set contents of myStory to myString
		--![Font collections.]
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
