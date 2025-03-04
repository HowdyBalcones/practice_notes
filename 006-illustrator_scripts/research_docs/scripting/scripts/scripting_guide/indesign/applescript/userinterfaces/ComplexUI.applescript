--ComplexUI.applescript
--An InDesign AppleScript
--
--Shows how to create a more complex dialog box.
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
		--![Complex UI.]
		set myDialog to make dialog
		--This example dialog box uses border panels and dialog columns to
		--separate and organize the user interface items in the dialog.
		tell myDialog
			set name to "User Interface Example Script"
			set myDialogColumn to make dialog column
			tell myDialogColumn
				set myBorderPanel to make border panel
				tell myBorderPanel
					set myDialogColumn to make dialog column
					tell myDialogColumn
						make static text with properties {static label:"Message:"}
					end tell
					set myDialogColumn to make dialog column
					tell myDialogColumn
						set myTextEditField to make text editbox with properties {edit contents:"Hello World!", min width:180}
					end tell
				end tell
				set myBorderPanel to make border panel
				tell myBorderPanel
					set myDialogColumn to make dialog column
					tell myDialogColumn
						make static text with properties {static label:"Point Size:"}
					end tell
					set myDialogColumn to make dialog column
					tell myDialogColumn
						set myPointSizeField to make measurement editbox with properties {edit value:72, edit units:points}
					end tell
				end tell
				set myBorderPanel to make border panel
				tell myBorderPanel
					set myDialogColumn to make dialog column
					tell myDialogColumn
						make static text with properties {static label:"Vertical Justification:"}
					end tell
					set myDialogColumn to make dialog column
					tell myDialogColumn
						set myVerticalJustificationMenu to make dropdown with properties {string list:{"Top", "Center", "Bottom"}, selected index:0}
					end tell
				end tell
				set myBorderPanel to make border panel
				tell myBorderPanel
					make static text with properties {static label:"Paragraph Alignment:"}
					set myParagraphAlignmentGroup to make radiobutton group
					tell myParagraphAlignmentGroup
						set myLeftRadioButton to make radiobutton control with properties {static label:"Left", checked state:true}
						set myCenterRadioButton to make radiobutton control with properties {static label:"Center"}
						set myRightRadioButton to make radiobutton control with properties {static label:"Right"}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			--Get the settings from the dialog box.
			--Get the point size from the point size field.
			set myPointSize to edit value of myPointSizeField
			--Get the example text from the text edit field.
			set myString to edit contents of myTextEditField
			--Get the vertical justification setting from the pop-up menu.
			if selected index of myVerticalJustificationMenu is 0 then
				set myVerticalJustification to top align
			else if selected index of myVerticalJustificationMenu is 1 then
				set myVerticalJustification to center align
			else
				set myVerticalJustification to bottom align
			end if
			--Get the paragraph alignment setting from the radiobutton group.
			get properties of myParagraphAlignmentGroup
			if selected button of myParagraphAlignmentGroup is 0 then
				set myParagraphAlignment to left align
			else if selected button of myParagraphAlignmentGroup is 1 then
				set myParagraphAlignment to center align
			else
				set myParagraphAlignment to right align
			end if
			--Remove the dialog box from memory.
			destroy myDialog
			my myMakeDocument(myPointSize, myString, myParagraphAlignment, myVerticalJustification)
		else
			destroy myDialog
		end if
	end tell
	--![Complex UI.]
end mySnippet
on myTeardown()
end myTeardown
--![Complex UI - functions.]
on myMakeDocument(myPointSize, myString, myParagraphAlignment, myVerticalJustification)
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
		end tell
		set myPage to page 1 of myDocument
		tell myPage
			set myTextFrame to make text frame
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
			--Apply the settings from the dialog box to the text frame.
			set contents of myTextFrame to myString
			--Apply the vertical justification setting.
			set vertical justification of text frame preferences of myTextFrame to myVerticalJustification
			--Apply the paragraph alignment ("justification").
			--"text 1 of myTextFrame" is all of the text in the text frame.
			set justification of text 1 of myTextFrame to myParagraphAlignment
			--Set the point size of the text in the text frame.
			set point size of text 1 of myTextFrame to myPointSize
		end tell
	end tell
end myMakeDocument
--![Complex UI - functions.]
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
