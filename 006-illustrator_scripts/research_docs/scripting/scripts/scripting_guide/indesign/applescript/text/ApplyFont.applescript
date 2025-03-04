--ApplyFont.applescript
--An InDesign AppleScript
--
--Shows how to get a list of fonts and display them in a dialog box,
--and how to apply a font to a range of text.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage), contents:placeholder text}
			end tell
			set myStory to parent story of myTextFrame
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--<fragment>
		--Given a document "myDocument" with a text frame on page 1...
		set myPage to page 1 of myDocument
		set myTextFrame to text frame 1 of myPage
		--Get story.
		set myS to parent story of myTextFrame
		--Get indexes to text range.
		set myB to index of character 1 of word 3 of paragraph 3 of myS
		set myE to the index of last character of paragraph 5 of myS
		--Get object reference to text range.
		set myT to object reference of text from character myB to character myE of myS
		--Select a font and apply to text range.
		set myFontName to my myDisplayDialog()
		if myFontName is not equal to "" then
			--set applied font of paragraph 1 of myStory to myFontName
			set applied font of myT to myFontName
		end if
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
--<fragment>
on myDisplayDialog()
	tell application "Adobe InDesign 2024"
		set myFontNamesList to the name of every font
		set myDialog to make dialog with properties {name:"Fonts"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Font Name:"}
					end tell
					tell (make dialog column)
						--Note: Dropdowns index from 0 ...
						set myProps to {string list:myFontNamesList, selected index:0}
						set myFontDropdown to make dropdown with properties myProps
					end tell
				end tell
			end tell
			set myResult to show myDialog
			if myResult = true then
				--Note: ... but myFontNamesList indexes from 1, so fix it.
				set correctedIndex to (selected index of myFontDropdown) + 1
				set myFontName to item correctedIndex of myFontNamesList
			else
				set myFontName to ""
			end if
			destroy myDialog
			return myFontName
		end tell
	end tell
end myDisplayDialog
--</fragment>
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
