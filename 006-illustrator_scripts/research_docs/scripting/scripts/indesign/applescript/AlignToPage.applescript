--AlignToPage.applescript
--An InDesign AppleScript
--
--Aligns the items in the selection to the specified location on the page.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--Or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
set myObjectList to {}
tell application "Adobe InDesign 2024"
	set myPageItemTypes to {rectangle, oval, polygon, text frame, graphic line, group}
	if (count documents) > 0 then
		set mySelection to selection
		if (count mySelection) > 0 then
			repeat with myCounter from 1 to (count mySelection)
				if (class of item myCounter of mySelection) is in myPageItemTypes then
					copy item myCounter of mySelection to end of myObjectList
				end if
			end repeat
			if (count myObjectList) > 0 then
				my myDisplayDialog(myObjectList)
			end if
		else
			display dialog "Please select a page item and try again."
		end if
	else
		display dialog "Please open a document, select a page item, and try again."
	end if
end tell
on myDisplayDialog(myObjectList)
	tell application "Adobe InDesign 2024"
		set myDialog to make dialog with properties {name:"AlignToPage"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					tell (make dialog column)
						tell (make border panel)
							make static text with properties {static label:"Vertical"}
							set myVerticalAlignmentButtons to make radiobutton group
							tell myVerticalAlignmentButtons
								make radiobutton control with properties {static label:"Top", checked state:true}
								make radiobutton control with properties {static label:"Center"}
								make radiobutton control with properties {static label:"Bottom"}
								make radiobutton control with properties {static label:"None"}
							end tell
						end tell
					end tell
					tell (make dialog column)
						tell (make border panel)
							make static text with properties {static label:"Horizontal"}
							set myHorizontalAlignmentButtons to make radiobutton group
							tell myHorizontalAlignmentButtons
								make radiobutton control with properties {static label:"Left", checked state:true}
								make radiobutton control with properties {static label:"Center"}
								make radiobutton control with properties {static label:"Right"}
								make radiobutton control with properties {static label:"None"}
							end tell
						end tell
					end tell
				end tell
				tell (make dialog row)
					set myConsiderMarginsCheckbox to make checkbox control with properties {static label:"Consider Page Margins", checked state:false}
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myVerticalAlignment to selected button of myVerticalAlignmentButtons
			set myHorizontalAlignment to selected button of myHorizontalAlignmentButtons
			set myConsiderMargins to checked state of myConsiderMarginsCheckbox
			destroy myDialog
			my myAlignObjects(myObjectList, myVerticalAlignment, myHorizontalAlignment, myConsiderMargins)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on myAlignObjects(myObjectList, myVerticalAlignment, myHorizontalAlignment, myConsiderMargins)
	tell application "Adobe InDesign 2024"
		set myPageHeight to page height of document preferences of active document
		set myPageWidth to page width of document preferences of active document
		set myOldRulerOrigin to ruler origin of view preferences of active document
		set ruler origin of view preferences of active document to page origin
		set zero point of active document to {0, 0}
		set myPage to active page of active window
		if myConsiderMargins is true then
			--In a facing pages layout, the "right" and "left"
			--margins become "inside" and "outside".
			tell margin preferences of myPage
				if side of myPage is left hand then
					set myOutsideMargin to left
					set myInsideMargin to right
					set myXCenter to myOutsideMargin + ((myPageWidth - (myInsideMargin + myOutsideMargin)) / 2)
				else
					set myInsideMargin to left
					set myOutsideMargin to right
					set myXCenter to myInsideMargin + ((myPageWidth - (myInsideMargin + myOutsideMargin)) / 2)
				end if
				set myTopMargin to top
				set myBottomMargin to bottom
				set myYCenter to myTopMargin + ((myPageHeight - (myTopMargin + myBottomMargin)) / 2)
			end tell
			if myHorizontalAlignment is 0 then
				set myX to myInsideMargin
			else if myHorizontalAlignment is 1 then
				set myX to myXCenter
			else if myHorizontalAlignment is 2 then
				set myX to myPageWidth - myOutsideMargin
			else if myHorizontalAlignment is 3 then
				set myX to nothing
			end if
			if myVerticalAlignment is 0 then
				set myY to myTopMargin
			else if myVerticalAlignment is 1 then
				set myY to myYCenter
			else if myVerticalAlignment is 2 then
				set myY to myPageHeight - myBottomMargin
			else if myVerticalAlignment is 3 then
				set myY to nothing
			end if
		else
			set myXCenter to myPageWidth / 2
			set myYCenter to myPageHeight / 2
			if myHorizontalAlignment is 0 then
				set myX to 0
			else if myHorizontalAlignment is 1 then
				set myX to myXCenter
			else if myHorizontalAlignment is 2 then
				set myX to myPageWidth
			else if myHorizontalAlignment is 3 then
				set myX to "None"
			end if
			if myVerticalAlignment is 0 then
				set myY to 0
			else if myVerticalAlignment is 1 then
				set myY to myYCenter
			else if myVerticalAlignment is 2 then
				set myY to myPageHeight
			else if myVerticalAlignment is 3 then
				set myY to "None"
			end if
		end if
		if not (myX is equal to "None" and myY is equal to "None") then
			repeat with myCounter from 1 to (count myObjectList)
				my myAlignObject(item myCounter of myObjectList, myX, myY, myHorizontalAlignment, myVerticalAlignment)
			end repeat
		end if
		set ruler origin of view preferences of active document to myOldRulerOrigin
	end tell
end myAlignObjects
on myAlignObject(myObject, myX, myY, myHorizontalAlignment, myVerticalAlignment)
	tell application "Adobe InDesign 2024"
		set myBounds to geometric bounds of myObject
		--Geometric bounds are in the form {y1, x1, y2, x2}
		set myWidth to (item 4 of myBounds) - (item 2 of myBounds)
		set myHeight to (item 3 of myBounds) - (item 1 of myBounds)
		if myHorizontalAlignment is 0 then
			--do nothing
		else if myHorizontalAlignment is 1 then
			set myX to myX - (myWidth / 2)
		else if myHorizontalAlignment is 2 then
			set myX to myX - myWidth
		else if myHorizontalAlignment is 3 then
			set myX to item 2 of myBounds
		end if
		if myVerticalAlignment is 0 then
			--do nothing
		else if myVerticalAlignment is 1 then
			set myY to myY - (myHeight / 2)
		else if myVerticalAlignment is 2 then
			set myY to myY - myHeight
		else if myVerticalAlignment is 3 then
			set myY to item 1 of myBounds
		end if
		tell myObject to move to {myX, myY}
	end tell
end myAlignObject
