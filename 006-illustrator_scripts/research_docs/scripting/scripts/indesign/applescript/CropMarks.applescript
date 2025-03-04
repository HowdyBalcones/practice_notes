--CropMarks.applescript
--An InDesign AppleScript.
--
--Draws crop marks and registration marks around the selected object(s).
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting forum at http://www.adobeforums.com
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
--This handler takes care of displaying the dialog box.
on myDisplayDialog(myObjectList)
	tell application "Adobe InDesign 2024"
		tell active document
			set myOldXUnits to horizontal measurement units of view preferences
			set myOldYUnits to vertical measurement units of view preferences
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
		end tell
		set myDialog to make dialog with properties {name:"CropMarks"}
		tell myDialog
			make dialog column
			tell the result
				set myCropMarksGroup to make enabling group with properties {static label:"Crop Marks", checked state:true}
				tell myCropMarksGroup
					make dialog column
					tell the result
						make static text with properties {static label:"Options"}
					end tell
					make dialog column
					tell the result
						make static text with properties {static label:"Length:"}
						make static text with properties {static label:"Offset:"}
						make static text with properties {static label:"Stroke Weight:"}
					end tell
					make dialog column
					tell the result
						set myCropMarkLengthField to make measurement editbox with properties {edit value:6, edit units:points}
						set myCropMarkOffsetField to make measurement editbox with properties {edit value:3, edit units:points}
						set myCropMarkWidthField to make measurement editbox with properties {edit value:0.25, edit units:points}
					end tell
				end tell
				set myRegMarksGroup to make enabling group with properties {static label:"Registration Marks", checked state:true}
				tell myRegMarksGroup
					make dialog column
					tell the result
						make static text with properties {static label:"Options"}
					end tell
					make dialog column
					tell the result
						make static text with properties {static label:"Radius:"}
						make static text with properties {static label:"Inside Radius:"}
						make static text with properties {static label:"Outside Radius:"}
						make static text with properties {static label:"Offset:"}
						make static text with properties {static label:"Stroke Weight:"}
					end tell
					make dialog column
					tell the result
						set myRegMarkRadiusField to make measurement editbox with properties {edit value:6, edit units:points}
						set myRegMarkInnerRadiusField to make measurement editbox with properties {edit value:2, edit units:points}
						set myRegMarkOuterRadiusField to make measurement editbox with properties {edit value:4, edit units:points}
						set myRegMarkOffsetField to make measurement editbox with properties {edit value:3, edit units:points}
						set myRegMarkStrokeWeightField to make measurement editbox with properties {edit value:0.25, edit units:points}
					end tell
				end tell
				make border panel
				tell the result
					make static text with properties {static label:"Draw Marks Around:"}
					set myRangeButtons to make radiobutton group
					tell myRangeButtons
						make radiobutton control with properties {static label:"Each Object", checked state:true}
						make radiobutton controls with properties {static label:"Entire Selection"}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			--Get the values from the dialog box.
			set myDoCropMarks to checked state of myCropMarksGroup
			set myDoRegMarks to checked state of myRegMarksGroup
			if ((myDoCropMarks is not equal to false) or (myDoRegMarks is not equal to false)) then
				set myCropMarkLength to edit value of myCropMarkLengthField
				set myCropMarkOffset to edit value of myCropMarkOffsetField
				set myCropMarkWidth to edit value of myCropMarkWidthField
				set myRegMarkRadius to edit value of myRegMarkRadiusField
				set myRegMarkInnerRadius to edit value of myRegMarkInnerRadiusField
				set myRegMarkOuterRadius to edit value of myRegMarkOuterRadiusField
				set myRegMarkOffset to edit value of myRegMarkOffsetField
				set myRegMarkWidth to edit value of myRegMarkStrokeWeightField
				set myRange to selected button of myRangeButtons
				destroy myDialog
				my myDrawPrintersMarks(myObjectList, myRange, myDoCropMarks, myDoRegMarks, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, myRegMarkInnerRadius, myRegMarkOuterRadius, myRegMarkOffset, myRegMarkWidth, myRegMarkRadius)
			else
				display dialog ("No printers marks were selected.")
			end if
		else
			destroy myDialog
		end if
		tell active document
			set horizontal measurement units of view preferences to myOldXUnits
			set vertical measurement units of view preferences to myOldYUnits
		end tell
	end tell
end myDisplayDialog

on myDrawPrintersMarks(myObjectList, myRange, myDoCropMarks, myDoRegMarks, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, myRegMarkInnerRadius, myRegMarkOuterRadius, myRegMarkOffset, myRegMarkWidth, myRegMarkRadius)
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myCropMarksLayerName to "CropMarksLayer"
		set myRegColor to swatch "Registration" of myDocument
		set myPaperColor to swatch "Paper" of myDocument
		--Save the current ruler origin setting.
		set myOldRulerOrigin to ruler origin of view preferences of myDocument
		--Set the ruler origin to spread origin. If we don't do this,
		--guides will be positioned incorrectly when the selection
		--contains objects on multiple pages.
		set ruler origin of view preferences of myDocument to spread origin
		
		try
			--Get the layer on which to place the crop marks.
			set myLayer to layer myCropMarksLayerName of myDocument
		on error
			--Create the layer if it didn't already exist.
			tell myDocument
				set myLayer to make layer with properties {name:myCropMarksLayerName}
			end tell
		end try
		--Get a reference to the current spread.
		set mySpread to active spread of active window
		--If myRange is true, draw crop marks around each item in the selection;
		--if it's false, draw crop marks around the bounding box of the selection.
		if myRange is 0 then
			repeat with myCounter from 1 to (count myObjectList)
				set myPageItem to item myCounter of myObjectList
				--Get the bounds of the item.
				set myBounds to geometric bounds of myPageItem
				set myY1 to (item 1 of myBounds)
				set myX1 to (item 2 of myBounds)
				set myY2 to (item 3 of myBounds)
				set myX2 to (item 4 of myBounds)
				--Calculate the horizontal center and vertical center of the object.
				set myXCenter to myX1 + ((myX2 - myX1) / 2)
				set myYCenter to myY1 + ((myY2 - myY1) / 2)
				--Draw crop marks around the object.
				if myDoCropMarks is true then
					my myDrawCropMarks(myX1, myY1, myX2, myY2, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, myRegMarkInnerRadius, myRegMarkOuterRadius, myRegMarkRadius, myXCenter, myYCenter)
				end if
				if myDoRegMarks is true then
					my myDrawRegMarks(myX1, myY1, myX2, myY2, myXCenter, myYCenter, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer)
				end if
			end repeat
		else
			repeat with myCounter from 1 to (count myObjectList)
				set myPageItem to item myCounter of myObjectList
				--Get the bounds of the item.
				set myBounds to geometric bounds of myPageItem
				if myCounter = 1 then
					set myY1 to (item 1 of myBounds)
					set myX1 to (item 2 of myBounds)
					set myY2 to (item 3 of myBounds)
					set myX2 to (item 4 of myBounds)
				else
					if item 1 of myBounds < myY1 then
						set myY1 to (item 1 of myBounds)
					end if
					if item 2 of myBounds < myX1 then
						set myX1 to (item 2 of myBounds)
					end if
					if item 3 of myBounds > myY2 then
						set myY2 to (item 3 of myBounds)
					end if
					if item 4 of myBounds > myX2 then
						set myX2 to (item 4 of myBounds)
					end if
				end if
			end repeat
			--Calculate the horizontal center and vertical center of the objects.
			set myXCenter to myX1 + ((myX2 - myX1) / 2)
			set myYCenter to myY1 + ((myY2 - myY1) / 2)
			--Draw crop marks around the object.
			if myDoCropMarks is true then
				my myDrawCropMarks(myX1, myY1, myX2, myY2, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, myRegMarkInnerRadius, myRegMarkOuterRadius, myRegMarkRadius, myXCenter, myYCenter)
			end if
			if myDoRegMarks is true then
				my myDrawRegMarks(myX1, myY1, myX2, myY2, myXCenter, myYCenter, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer)
			end if
		end if
		set ruler origin of view preferences of myDocument to myOldRulerOrigin
	end tell
end myDrawPrintersMarks
on myDrawCropMarks(myX1, myY1, myX2, myY2, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, myRegMarkInnerRadius, myRegMarkOuterRadius, myInnerRadius, myXCenter, myYCenter)
	--Draw crop marks around the object.
	--Draw the upper left crop mark pair.
	my myDrawCropMark(myX1, myY1, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, "top_left", mySpread, myRegColor, myLayer)
	--Draw the upper right crop mark pair.
	my myDrawCropMark(myX2, myY1, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, "top_right", mySpread, myRegColor, myLayer)
	--Draw the bottom right crop mark pair.
	my myDrawCropMark(myX2, myY2, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, "bottom_right", mySpread, myRegColor, myLayer)
	--Draw the bottom left crop mark pair.
	my myDrawCropMark(myX1, myY2, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, "bottom_left", mySpread, myRegColor, myLayer)
end myDrawCropMarks
on myDrawRegMarks(myX1, myY1, myX2, myY2, myXCenter, myYCenter, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer)
	--Draw registration marks around the object
	--Draw the left registration mark.
	my myDrawRegMark(myX1, myYCenter, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, "left")
	--Draw the right registration mark.
	my myDrawRegMark(myX2, myYCenter, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, "right")
	--Draw the top registration mark.
	my myDrawRegMark(myXCenter, myY1, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, "top")
	--Draw the bottom registration mark.
	my myDrawRegMark(myXCenter, myY2, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, "bottom")
end myDrawRegMarks
on myDrawCropMark(myX, myY, myCropMarkLength, myCropMarkOffset, myCropMarkWidth, myPosition, mySpread, myRegColor, myLayer)
	tell application "Adobe InDesign 2024"
		tell mySpread
			if myPosition = "top_left" then
				make graphic line with properties {geometric bounds:{myY, myX - myCropMarkOffset, myY, myX - (myCropMarkOffset + myCropMarkLength)}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
				make graphic line with properties {geometric bounds:{myY - myCropMarkOffset, myX, myY - (myCropMarkOffset + myCropMarkLength), myX}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
			else if myPosition = "top_right" then
				make graphic line with properties {geometric bounds:{myY, myX + myCropMarkOffset, myY, myX + (myCropMarkOffset + myCropMarkLength)}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
				make graphic line with properties {geometric bounds:{myY - myCropMarkOffset, myX, myY - (myCropMarkOffset + myCropMarkLength), myX}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
			else if myPosition = "bottom_right" then
				make graphic line with properties {geometric bounds:{myY, myX + myCropMarkOffset, myY, myX + (myCropMarkOffset + myCropMarkLength)}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
				make graphic line with properties {geometric bounds:{myY + myCropMarkOffset, myX, myY + (myCropMarkOffset + myCropMarkLength), myX}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
			else if myPosition = "bottom_left" then
				make graphic line with properties {geometric bounds:{myY, myX - myCropMarkOffset, myY, myX - (myCropMarkOffset + myCropMarkLength)}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
				make graphic line with properties {geometric bounds:{myY + myCropMarkOffset, myX, myY + (myCropMarkOffset + myCropMarkLength), myX}, stroke weight:myCropMarkWidth, stroke color:myRegColor, item layer:myLayer}
			end if
		end tell
	end tell
end myDrawCropMark
on myDrawRegMark(myX, myY, myRegMarkOffset, myRegMarkRadius, myRegMarkOuterRadius, myRegMarkInnerRadius, myRegMarkWidth, mySpread, myRegColor, myPaperColor, myLayer, myPosition)
	tell application "Adobe InDesign 2024"
		set myNone to swatch "None" of active document
		if myPosition = "top" then
			set myY to myY - (myRegMarkOffset + myRegMarkRadius)
		else if myPosition = "left" then
			set myX to myX - (myRegMarkOffset + myRegMarkRadius)
		else if myPosition = "right" then
			set myX to myX + (myRegMarkOffset + myRegMarkRadius)
		else if myPosition = "bottom" then
			set myY to myY + (myRegMarkOffset + myRegMarkRadius)
		end if
		tell mySpread
			--Outside horizontal
			make graphic line with properties {geometric bounds:{myY, myX - myRegMarkRadius, myY, myX + myRegMarkRadius}, stroke weight:myRegMarkWidth, stroke color:myRegColor, item layer:myLayer, label:"myCropMark"}
			--Outside vertical
			make graphic line with properties {geometric bounds:{myY - myRegMarkRadius, myX, myY + myRegMarkRadius, myX}, stroke weight:myRegMarkWidth, stroke color:myRegColor, item layer:myLayer, label:"myCropMark"}
			--Outside circle
			make oval with properties {geometric bounds:{myY - myRegMarkOuterRadius, myX - myRegMarkOuterRadius, myY + myRegMarkOuterRadius, myX + myRegMarkOuterRadius}, stroke weight:myRegMarkWidth, stroke color:myRegColor, fill color:myNone, item layer:myLayer, label:"myCropMark"}
			--Inside circle
			make oval with properties {geometric bounds:{myY - myRegMarkInnerRadius, myX - myRegMarkInnerRadius, myY + myRegMarkInnerRadius, myX + myRegMarkInnerRadius}, stroke weight:0, stroke color:myNone, fill color:myRegColor, item layer:myLayer, label:"myCropMark"}
			--Inside horizontal
			make graphic line with properties {geometric bounds:{myY, myX - myRegMarkInnerRadius, myY, myX + myRegMarkInnerRadius}, stroke weight:myRegMarkWidth, stroke color:myPaperColor, item layer:myLayer, label:"myCropMark"}
			--Inside vertical
			make graphic line with properties {geometric bounds:{myY - myRegMarkInnerRadius, myX, myY + myRegMarkInnerRadius, myX}, stroke weight:myRegMarkWidth, stroke color:myPaperColor, item layer:myLayer, label:"myCropMark"}
		end tell
	end tell
end myDrawRegMark
