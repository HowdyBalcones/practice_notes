--TabUtilities.applescript
--An InDesign AppleScript
--
--Adds a right tab stop at the right column edge, or a tab stop at the current 
--cursor position, or sets the left indent at the current cursor position.
--Demonstrates getting page layout coordinates from text objects, setting tab stops,
--working with multi-column text frames.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InDesign 2024"
	set myTextObjects to {insertion point, character, word, line, text style range, paragraph, text column, text, story, text frame}
	if (count documents) > 0 then
		set mySelection to selection
		if (count mySelection) > 0 then
			if class of item 1 of mySelection is in myTextObjects then
				my myDisplayDialog()
			else
				display dialog ("Please select some text (or a text frame) try again.")
			end if
		else
			display dialog ("Nothing is selected. Please select some text (or a text frame) try again.")
		end if
	else
		display dialog ("No documents are open. Please open a document and try again.")
	end if
end tell
--Display a dialog box.
on myDisplayDialog()
	tell application "Adobe InDesign 2024"
		set myDialog to make dialog with properties {name:"TabUtilities"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					make static text with properties {static label:"Set a Tab Stop At:"}
					set myTabButtons to make radiobutton group
					tell myTabButtons
						make radiobutton control with properties {static label:"Right Column Edge", checked state:true}
						make radiobutton control with properties {static label:"Current Cursor Position"}
						make radiobutton control with properties {static label:"Left Indent"}
						make radiobutton control with properties {static label:"Hanging Indent at Cursor"}
					end tell
				end tell
				tell (make border panel)
					make static text with properties {static label:"Tab Leader"}
					tell (make dialog column)
						set myTabLeaderField to make text editbox with properties {edit contents:""}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult = true then
			set myTabType to selected button of myTabButtons
			set myTabLeader to edit contents of myTabLeaderField
			destroy myDialog
			my myAddTabStop(myTabType, myTabLeader)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
--Add the tab stop.
on myAddTabStop(myTabType, myLeader)
	tell application "Adobe InDesign 2024"
		set mySelection to object reference of selection
		if myTabType = 0 then
			set myParagraphs to object reference of paragraphs of item 1 of mySelection
			repeat with myCounter from 1 to (count myParagraphs)
				set myParagraph to object reference of item myCounter of myParagraphs
				set myTabPosition to text column fixed width of text frame preferences of item 1 of parent text frames of insertion point 1 of myParagraph
				set myTabAlignment to right align
				tell myParagraph
					make tab stop with properties {alignment:myTabAlignment, leader:myLeader, position:myTabPosition}
				end tell
			end repeat
		else if myTabType = 1 then
			--Get the first insertion point in the selection.
			set myInsertionPoint to insertion point 1 of item 1 of mySelection
			--Work out which column it's in and get the left edge of that column.
			set myTabPosition to (horizontal offset of myInsertionPoint) - (my myFindColumnEdge(myInsertionPoint))
			set myTabAlignment to left align
			tell paragraph 1 of myInsertionPoint
				make tab stop with properties {alignment:myTabAlignment, leader:myLeader, position:myTabPosition}
			end tell
		else if myTabType = 2 then
			set myParagraphs to object reference of paragraphs of item 1 of mySelection
			repeat with myCounter from 1 to (count myParagraphs)
				set myParagraph to item myCounter of myParagraphs
				set myTabPosition to left indent of myParagraph
				set myTabAlignment to left align
				tell myParagraph
					make tab stop with properties {alignment:myTabAlignment, leader:myLeader, position:myTabPosition}
				end tell
			end repeat
		else if myTabType = 3 then
			set myParagraphs to object reference of paragraphs of item 1 of mySelection
			--Get the first insertion point in the selection.
			set myInsertionPoint to insertion point 1 of mySelection
			--Work out which column it's in and get the left edge of that column.
			set myTabPosition to (horizontal offset of myInsertionPoint) - (my myFindColumnEdge(myInsertionPoint))
			set myTabAlignment to left align
			repeat with myCounter from 1 to (count myParagraphs)
				set myParagraph to item myCounter of myParagraphs
				set left indent of myParagraph to myTabPosition
				set first line indent of myParagraph to -myTabPosition
				tell myParagraph
					make tab stop with properties {alignment:myTabAlignment, leader:myLeader, position:myTabPosition}
				end tell
			end repeat
		end if
	end tell
end myAddTabStop
--This function returns the left edge of the text column containing the insertion point,
--in page coordinates. It could be modified to return the index of the column, as well.
on myFindColumnEdge(myInsertionPoint)
	tell application "Adobe InDesign 2024"
		set myPagePosition to horizontal offset of myInsertionPoint
		set myTextFrame to item 1 of parent text frames of myInsertionPoint
		if class of myTextFrame is list then
			set myTextFrame to item 1 of myTextFrame
		end if
		set myColumnWidth to text column fixed width of text frame preferences of myTextFrame
		set myGutterWidth to text column gutter of text frame preferences of myTextFrame
		set {myY1, myX1, myY2, myX2} to geometric bounds of myTextFrame
		set myTextFrameWidth to myX2 - myX1
		--Get the distance from the insertion point to the left edge of the text frame.
		set myXOffset to myPagePosition - myX1
		set myArray to {}
		set myInsetSpacing to inset spacing of text frame preferences of myTextFrame
		--If the text frame is rectangular, the insetSpacing array will
		--have four values if it's not rectangular, insetSpacing will have one value.
		if (count myInsetSpacing) = 4 then
			set myLeftInset to item 2 of inset spacing of text frame preferences of myTextFrame
			set myRightInset to item 4 of inset spacing of text frame preferences of myTextFrame
		else
			set myLeftInset to item 1 of inset spacing of textFramePreferences of myTextFrame
			set myRightInset to myLeftInset
		end if
		repeat with myCounter from 1 to text column count of text frame preferences of myTextFrame
			if myCounter = 1 then
				set myX1 to (item 2 of geometric bounds of myTextFrame) + myLeftInset
				set myX2 to myX1 + myColumnWidth
			else
				set myX1 to (item 2 of geometric bounds of myTextFrame) + (myColumnWidth * (myCounter - 1)) + (myGutterWidth * ((myCounter - 1))) + myLeftInset
				set myX2 to myX1 + myColumnWidth
			end if
			copy {myX1, myX2} to end of myArray
		end repeat
		repeat with myCounter from 1 to (count myArray)
			set myItem to item myCounter of myArray
			if myPagePosition >= item 1 of myItem and myPagePosition <= item 2 of myItem then
				set myColumnEdge to item 1 of item myCounter of myArray
				--Found the column edge, so stop looping.
				exit repeat
			end if
		end repeat
	end tell
	return myColumnEdge
end myFindColumnEdge
