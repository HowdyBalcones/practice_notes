--ApplyFont.applescript
--An InCopy CS2 AppleScript
--
--Shows how to get a list of fonts and display them in a dialog box,
--and how to apply a font to a range of text.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		set myFontName to my myDisplayDialog()
		if myFontName is not equal to "" then
			set applied font of paragraph 1 of myStory to myFontName
		end if
	end tell
end mySnippet
on myDisplayDialog()
	tell application "Adobe InCopy 2024"
		set myFontNamesList to the name of every font
		set myDialog to make dialog with properties {name:"Fonts"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Font Name:"}
					end tell
					tell (make dialog column)
						set myFontDropdown to make dropdown with properties {string list:myFontNamesList, selected index:1}
					end tell
				end tell
			end tell
			set myResult to show myDialog
			if myResult = true then
				set myFontName to item (selected index of myFontDropdown) of myFontNamesList
			else
				set myFontName to ""
			end if
			destroy myDialog
			return myFontName
		end tell
	end tell
end myDisplayDialog
on mySetup()
	tell application "Adobe InCopy 2024"
		set myDocument to make document
		set myStory to story 1 of myDocument
		set myTextFrame to item 1 of text containers of myStory
		set contents of myTextFrame to placeholder text
	end tell
end mySetup
