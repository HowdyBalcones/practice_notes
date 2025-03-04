--MakeGrid.applescript
--An InDesign AppleScript
--
--Divides the selected frame (or frames) into grid(s) of frames.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
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
		set myLabelWidth to 100
		set myFrameTypes to {"Unassigned", "Text", "Graphic"}
		set myDialog to make dialog with properties {name:"MakeGrid"}
		tell myDialog
			tell (make dialog column)
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Rows:", min width:myLabelWidth}
						make static text with properties {static label:"Columns:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myNumberOfRowsField to make integer editbox with properties {edit value:2}
						set myNumberOfColumnsField to make integer editbox with properties {edit value:2}
					end tell
				end tell
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Row Gutter:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myRowGutterField to make measurement editbox with properties {edit value:12, edit units:points}
					end tell
				end tell
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Column Gutter:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myColumnGutterField to make measurement editbox with properties {edit value:12, edit units:points}
					end tell
				end tell
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Frame Type:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myFrameTypeDropdown to make dropdown with properties {string list:myFrameTypes, selected index:0}
					end tell
				end tell
				set myRetainFormattingCheckbox to make checkbox control with properties {static label:"Retain Formatting and Contents", checked state:true}
				set myDeleteObjectCheckbox to make checkbox control with properties {static label:"Delete Original Object", checked state:true}
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myNumberOfRows to edit value of myNumberOfRowsField
			set myNumberOfColumns to edit value of myNumberOfColumnsField
			set myRowGutter to edit value of myRowGutterField
			set myColumnGutter to edit value of myColumnGutterField
			set myRetainFormatting to checked state of myRetainFormattingCheckbox
			set myDeleteObject to checked state of myDeleteObjectCheckbox
			get selected index of myFrameTypeDropdown
			if selected index of myFrameTypeDropdown is 0 then
				set myFrameType to unassigned
			else if selected index of myFrameTypeDropdown is 1 then
				set myFrameType to text type
			else if selected index of myFrameTypeDropdown is 2 then
				set myFrameType to graphic type
			end if
			destroy myDialog
			my mySplitFrames(myObjectList, myNumberOfRows, myNumberOfColumns, myRowGutter, myColumnGutter, myFrameType, myRetainFormatting, myDeleteObject)
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on mySplitFrames(myObjectList, myNumberOfRows, myNumberOfColumns, myRowGutter, myColumnGutter, myFrameType, myRetainFormatting, myDeleteObject)
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--Save the current measurement units.
		set myOldXUnits to horizontal measurement units of view preferences of myDocument
		set myOldYUnits to vertical measurement units of view preferences of myDocument
		--Set the current measurement units to points.
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		repeat with myCounter from 1 to (count myObjectList)
			my mySplitFrame(item myCounter of myObjectList, myNumberOfRows, myNumberOfColumns, myRowGutter, myColumnGutter, myFrameType, myRetainFormatting, myDeleteObject)
		end repeat
		set horizontal measurement units of view preferences of myDocument to myOldXUnits
		set vertical measurement units of view preferences of myDocument to myOldYUnits
	end tell
end mySplitFrames
on mySplitFrame(myObject, myNumberOfRows, myNumberOfColumns, myRowGutter, myColumnGutter, myFrameType, myRetainFormatting, myDeleteObject)
	tell application "Adobe InDesign 2024"
		set myBounds to geometric bounds of myObject
		set myWidth to (item 4 of myBounds) - (item 2 of myBounds)
		set myHeight to (item 3 of myBounds) - (item 1 of myBounds)
		--Don't bother making the frames if the width/height of the frame is too small
		--to accomodate the row/column gutter values.	
		if ((myRowGutter * (myNumberOfRows - 1) < myHeight) and (myColumnGutter * (myNumberOfColumns - 1) < myWidth)) then
			set myColumnWidth to (myWidth - (myColumnGutter * (myNumberOfColumns - 1))) / myNumberOfColumns
			set myRowHeight to (myHeight - (myRowGutter * (myNumberOfRows - 1))) / myNumberOfRows
			repeat with myRowCounter from 0 to myNumberOfRows - 1
				set myY1 to (item 1 of myBounds) + (myRowHeight * myRowCounter) + (myRowGutter * myRowCounter)
				set myY2 to myY1 + myRowHeight
				repeat with myColumnCounter from 0 to myNumberOfColumns - 1
					set myX1 to (item 2 of myBounds) + (myColumnWidth * myColumnCounter) + (myColumnGutter * myColumnCounter)
					set myX2 to myX1 + myColumnWidth
					if myRetainFormatting is true then
						set myNewObject to duplicate myObject
						set geometric bounds of myNewObject to {myY1, myX1, myY2, myX2}
					else
						tell parent of myObject
							set myNewObject to make rectangle with properties {geometric bounds:{myY1, myX1, myY2, myX2}, content type:myFrameType}
						end tell
					end if
				end repeat
			end repeat
			if myDeleteObject is true then
				delete myObject
			end if
		end if
	end tell
end mySplitFrame
