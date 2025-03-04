--ComplexUI.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to create a more complex dialog box.
tell application "Adobe InCopy 2024"
	set myDocument to make document
	set mySwatchNames to name of every swatch of myDocument
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
					set myPointSizeField to make real editbox with properties {edit contents:"72"}
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
			set myBorderPanel to make border panel
			tell myBorderPanel
				make static text with properties {static label:"Text Color:"}
				set mySwatchesDropdown to make dropdown with properties {string list:mySwatchNames, selected index:1}
			end tell
		end tell
		show
		--Get the settings from the dialog box.
		--Get the point size from the point size field.
		set myPointSize to edit contents of myPointSizeField as real
		--Get the example text from the text edit field.
		set myString to edit contents of myTextEditField
		--Get the paragraph alignment setting from the radiobutton group.
		get properties of myParagraphAlignmentGroup
		if selected button of myParagraphAlignmentGroup is 0 then
			set myParagraphAlignment to left align
		else if selected button of myParagraphAlignmentGroup is 1 then
			set myParagraphAlignment to center align
		else
			set myParagraphAlignment to right align
		end if
		--Get the text color selected in the dropdown.
		set mySwatchName to item ((selected index of mySwatchesDropdown) + 1) of mySwatchNames
		--Remove the dialog box from memory.
		destroy myDialog
	end tell
	tell story 1 of myDocument
		--Apply the settings from the dialog box to the text frame.
		set contents to myString
		--Apply the paragraph alignment ("justification").
		--"text 1 of myStory" is all of the text in the text story.
		set justification of text 1 to myParagraphAlignment
		--Set the point size of the text in the text frame.
		set point size of text 1 to myPointSize
		--Set the fill color of the text to the selected swatch.
		set fill color of text 1 to swatch mySwatchName of myDocument
	end tell
end tell
