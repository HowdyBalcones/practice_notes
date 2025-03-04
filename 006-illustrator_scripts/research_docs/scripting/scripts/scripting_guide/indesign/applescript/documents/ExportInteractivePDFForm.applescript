--ExportInteractivePDFForm.applescript
--An InDesign C6 AppleScript
--
--Export an interactive PDF file with input text field and submit button
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell document preferences of myDocument
			set pages per document to 1
			set facing pages to false
			set page width to 600
			set page height to 800
		end tell
		--Create color model
		my myAddColor(myDocument, "Red", RGB, process, {255, 0, 0})
		my myAddColor(myDocument, "Blue", RGB, process, {0, 0, 255})
		my myAddColor(myDocument, "Green", RGB, process, {0, 255, 0})
	end tell
end mySetup
--</setup>
--<snippet>
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
         --![Export as a PDF form.]
		tell page 1 of myDocument
			--Create a textframe as firstname label
			set myTextFrame to make text frame with properties {geometric bounds:{15, 15, 20, 35}, contents:"FirstName: "}
			--Create a textbox as firstname input box
			set myTextBox to make text box with properties {geometric bounds:{15, 40, 20, 75}}
			--Create another textframe as lastname label
			set myTextFrame1 to make text frame with properties {geometric bounds:{30, 15, 25, 35}, contents:"LastName: "}
			--Create another textbox as lastname input box
			set myTextBox to make text box with properties {geometric bounds:{30, 40, 25, 75}}
			--Create a TextFrame to introduce the following checkbox
			set myTextFrame2 to make text frame with properties {geometric bounds:{15, 80, 20, 95}, contents:"Hobby:"}
			--Create some CheckBoxes
			set myCheckBox to make check box with properties {geometric bounds:{15, 100, 20, 105}, name:"Football"}
			set myTextFrame3 to make text frame with properties {geometric bounds:{15, 107, 20, 125}, contents:"Football"}
			set myCheckBox1 to make check box with properties {geometric bounds:{15, 130, 20, 135}, name:"Basketball"}
			set myTextFrame4 to make text frame with properties {geometric bounds:{15, 137, 20, 160}, contents:"Basketball"}
			set myCheckBox2 to make check box with properties {geometric bounds:{15, 165, 20, 170}, name:"Pingpong"}
			set myTextFrame5 to make text frame with properties {geometric bounds:{15, 172, 20, 193}, contents:"Pingpong"}
			--Create a button for submit
			set submitButton to make button with properties {geometric:{45, 15, 35, 35}, name:"Submit"}
		end tell
		tell state 1 of submitButton
			set myRightArrow1 to make polygon with properties {fill color:color "Green" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRightArrow1 to {{15, 35}, {35, 40}, {15, 45}}
		end tell
		--Add the Rollover state.
		tell submitButton
			set myRolloverState1 to make state
		end tell
		tell myRolloverState1
			set myRolloverArrow1 to make polygon with properties {fill color:color "Green" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRolloverArrow1 to {{15, 35}, {35, 40}, {15, 45}}
			--Add a shadow to the polygon in the Rollover state.
		end tell
		tell drop shadow settings of fill transparency settings of myRolloverArrow1
			set mode to drop
			set angle to 90
			set x offset to 0
			set y offset to 0
			set size to 6
		end tell
		tell submitButton
			set myClickState1 to make state
		end tell
		tell myClickState1
			set myClickArrow1 to make polygon with properties {fill color:color "Blue" of myDocument, stroke color:"None"}
			set entire path of path 1 of myClickArrow1 to {{15, 35}, {35, 40}, {15, 45}}
		end tell
		--Set the behavior for the button.
		tell submitButton
			set submitForm to make submit form behaviors with properties {behavior event:mouse up}
		end tell
		
		tell page 1 of myDocument
			--Create a button for print
			set printButton to make button with properties {geometric:{45, 15, 35, 35}, name:"Submit"}
		end tell
		tell state 1 of printButton
			set myRightArrow2 to make polygon with properties {fill color:color "Red" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRightArrow2 to {{40, 35}, {60, 40}, {40, 45}}
		end tell
		--Add the Rollover state.
		tell printButton
			set myRolloverState2 to make state
		end tell
		tell myRolloverState2
			set myRolloverArrow2 to make polygon with properties {fill color:color "Red" of myDocument, stroke color:"None"}
			set entire path of path 1 of myRolloverArrow2 to {{40, 35}, {60, 40}, {40, 45}}
			--Add a shadow to the polygon in the Rollover state.
		end tell
		tell drop shadow settings of fill transparency settings of myRolloverArrow2
			set mode to drop
			set angle to 90
			set x offset to 0
			set y offset to 0
			set size to 6
		end tell
		tell printButton
			set myClickState2 to make state
		end tell
		tell myClickState2
			set myClickArrow2 to make polygon with properties {fill color:color "Blue" of myDocument, stroke color:"None"}
			set entire path of path 1 of myClickArrow2 to {{40, 35}, {60, 40}, {40, 45}}
		end tell
		--Set the behavior for the button.
		tell printButton
			set PrintForm to make print form behaviors with properties {behavior event:mouse up}
		end tell
		--Export the document to PDF.
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "SubmitForm.pdf"
		tell myDocument
			export format interactive PDF to myFile without showing options
		end tell
     --![Export as a PDF form.]
	end tell
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
on myAddColor(myDocument, myColorName, myColorSpace, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
		tell myDocument
			try
				set myColor to color myColorName
			on error
				set myColor to make color with properties {name:myColorName}
			end try
			set properties of myColor to {space:myColorSpace, model:myColorModel, color value:myColorValue}
			return myColor
		end tell
	end tell
end myAddColor
--</teardown>
