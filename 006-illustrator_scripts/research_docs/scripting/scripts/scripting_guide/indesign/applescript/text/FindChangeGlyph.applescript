--FindChangeGlyph.applescript
--An InDesign AppleScript
--
--Demonstrates the find glyph and change glyph features.
my main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
		set myStory to parent story of myTextFrame
		set myString to "This is an example paragraph containing a specific glyph: <25A0>." & return
		set myString to myString & "This is a paragraph containing a specific glyph:<25A0>." & return
		set myString to myString & "This is another paragraph containing a specific glyph:<25A0>." & return
		set contents of myStory to myString
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Find change glyph.]
		--Clear glyph search preferences.
		set find glyph preferences to nothing
		set change glyph preferences to nothing
		set myDocument to document 1
		--You must provide a font that is used in the document for the
		--applied font property of the find glyph preferences object.
		set applied font of find glyph preferences to applied font of character 1 of story 1 of myDocument
		--Provide the glyph ID, not the glyph Unicode value.
		set glyph ID of find glyph preferences to 374
		--The applied font of the change glyph preferences object can be
		--any font available to the application.
		set applied font of change glyph preferences to "ITC Zapf Dingbats	Medium"
		set glyph ID of change glyph preferences to 85
		tell myDocument
			change glyph
		end tell
		--Clear glyph search preferences.
		set find glyph preferences to nothing
		set change glyph preferences to nothing
		--![Find change glyph.]
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
