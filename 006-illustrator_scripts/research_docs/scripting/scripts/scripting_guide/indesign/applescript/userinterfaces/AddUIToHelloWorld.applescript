--AddUIToHelloWorld.applescript
--An InDesign AppleScript
--
--Shows how to create a simple dialog box and use the
--dialog box settings in a script.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Add UI to HelloWorld.]
		set myDialog to make dialog
		tell myDialog
			set name to "Simple User Interface Example Script"
			set myDialogColumn to make dialog column
			tell myDialogColumn
				--Create a text entry field.
				set myTextEditField to make text editbox with properties {edit contents:"Hello World!", min width:180}
				--Create a number (real) entry field
				set myPointSizeField to make measurement editbox with properties {edit value:72, edit units:points}
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			--Get the settings from the dialog box.
			--Get the point size from the point size field.
			set myPointSize to edit value of myPointSizeField
			--Get the example text from the text edit field.
			set myString to edit contents of myTextEditField
			--Remove the dialog box from memory.
			destroy myDialog
			my myMakeDocument(myPointSize, myString)
		else
			destroy myDialog
		end if
		--![Add UI to HelloWorld.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![Add UI to HelloWorld - functions.]
on myMakeDocument(myPointSize, myString)
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
		end tell
		tell page 1 of myDocument
			--Create a text frame.
			set myTextFrame to make text frame
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, page 1 of myDocument)
			--Apply the settings from the dialog box to the text frame.
			set contents of myTextFrame to myString
			--Set the point size of the text in the text frame.
			set point size of text 1 of myTextFrame to myPointSize
		end tell
	end tell
end myMakeDocument
--![Add UI to HelloWorld - functions.]
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
