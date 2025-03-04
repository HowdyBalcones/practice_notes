--AddGuides.applescript
--An InDesign AppleScript
--
--Adds guides around the selected object(s).
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting forum at http://www.adobeforums.com
--
tell application "Adobe InDesign 2024"
	--Set the user interaction level to allow InDesign to display dialog boxes and alerts.
	set user interaction level of script preferences to interact with all
	set myObjectTypeList to {rectangle, oval, polygon, graphic line, text frame}
	if (count documents) is not equal to 0 then
		set mySelection to selection
		if (count mySelection) is not equal to 0 then
			set myClass to class of item 1 of mySelection
			if myClass is in myObjectTypeList then
				my myDisplayDialog()
			else
				display dialog "Please select a rectangle, oval, polygon, graphic line, or text frame, and try again."
			end if
		else
			display dialog "No objects are selected. Please select an object and try again."
		end if
	else
		display dialog "No documents are open. Please open a document, select an object, and try again."
	end if
end tell
--handler for displaying the AddGuides dialog box
on myDisplayDialog()
	tell application "Adobe InDesign 2024"
		set myDialog to make dialog with properties {name:"AddGuides"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Add Guides At:"}
					end tell
					tell (make dialog column)
						set myTopCheckbox to make checkbox control with properties {static label:"Top", checked state:true}
						set myLeftCheckbox to make checkbox control with properties {static label:"Left", checked state:true}
						set myBottomCheckbox to make checkbox control with properties {static label:"Bottom", checked state:true}
						set myRightCheckbox to make checkbox control with properties {static label:"Right", checked state:true}
						set myXCenterCheckbox to make checkbox control with properties {static label:"Horizontal Center", checked state:true}
						set myYCenterCheckbox to make checkbox control with properties {static label:"Vertical Center", checked state:true}
						set myXPointCheckbox to make checkbox control with properties {static label:"Path Point Horizontal Anchor", checked state:true}
						set myYPointCheckbox to make checkbox control with properties {static label:"Path Point Horizontal Anchor", checked state:true}
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Add Guides Around:"}
					end tell
					tell (make dialog column)
						set myRangeButtons to make radiobutton group
						tell myRangeButtons
							make radiobutton control with properties {static label:"Each Object", checked state:true}
							make radiobutton control with properties {static label:"Entire Selection"}
						end tell
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Guides Based On:"}
					end tell
					tell (make dialog column)
						set myBasedOnButtons to make radiobutton group
						tell myBasedOnButtons
							make radiobutton control with properties {static label:"Geometric Bounds", checked state:true}
							make radiobutton control with properties {static label:"Visible Bounds"}
						end tell
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			--Get the control settings from the dialog box.
			set myTopAlign to checked state of myTopCheckbox
			set myLeftAlign to checked state of myLeftCheckbox
			set myBottomAlign to checked state of myBottomCheckbox
			set myRightAlign to checked state of myRightCheckbox
			set myXCenterAlign to checked state of myXCenterCheckbox
			set myYCenterAlign to checked state of myYCenterCheckbox
			set myXPoint to checked state of myXPointCheckbox
			set myYPoint to checked state of myYPointCheckbox
			set myRange to selected button of myRangeButtons
			set myBasedOn to selected button of myBasedOnButtons
			destroy myDialog
			if (myTopAlign or myLeftAlign or myBottomAlign or myRightAlign or myXCenterAlign or myYCenterAlign or myXPoint or myYPoint) then
				my myAddGuides(myTopAlign, myLeftAlign, myBottomAlign, myRightAlign, myXCenterAlign, myYCenterAlign, myRange, myBasedOn, myXPoint, myYPoint)
			else
				display dialog "No guides were selected."
			end if
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog
on myAddGuides(myTopAlign, myLeftAlign, myBottomAlign, myRightAlign, myXCenterAlign, myYCenterAlign, myRange, myBasedOn, myXPoint, myYPoint)
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set mySelection to selection
		set myGuidesLayerName to "Guides"
		try
			--Get the layer on which to place the guides.
			set myLayer to layer myGuidesLayerName of myDocument
		on error
			--Create the layer if it didn't already exist.
			tell myDocument
				set myLayer to make layer with properties {name:myGuidesLayerName}
			end tell
		end try
		--Save the current ruler origin setting.
		set myOldRulerOrigin to ruler origin of view preferences of myDocument
		--Set the ruler origin to spread origin. If we don't do this,
		--guides will be positioned incorrectly when the selection
		--contains objects on multiple pages.
		set ruler origin of view preferences of myDocument to spread origin
		--Get a reference to the current spread.
		set mySpread to active spread of active window
		--If myRange is 0, draw crop marks around each item in the selection;
		--if it's 1, draw crop marks around the bounding box of the selection.
		if myRange is 0 then
			repeat with myCounter from 1 to (count mySelection)
				set myPageItem to item myCounter of mySelection
				if myXPoint is true or myYPoint is true then
					my myDrawGuidesAtPoints(myPageItem, myXPoint, myYPoint, myLayer, mySpread)
				end if
				--Get the bounds of the item (using geometric bounds if myBasedOn is 0, or visible bounds if it's 1)
				if myBasedOn = 0 then
					set myBounds to geometric bounds of myPageItem
				else
					set myBounds to visible bounds of myPageItem
				end if
				set myY1 to (item 1 of myBounds)
				set myX1 to (item 2 of myBounds)
				set myY2 to (item 3 of myBounds)
				set myX2 to (item 4 of myBounds)
				--Calculate the horizontal center and vertical center of the object.
				set myXCenter to myX1 + ((myX2 - myX1) / 2)
				set myYCenter to myY1 + ((myY2 - myY1) / 2)
				--Draw guides at the specified locations.
				if myTopAlign is true then
					my myDrawGuide(myY1, horizontal, myLayer, mySpread)
				end if
				if myLeftAlign is true then
					my myDrawGuide(myX1, vertical, myLayer, mySpread)
				end if
				if myBottomAlign is true then
					my myDrawGuide(myY2, horizontal, myLayer, mySpread)
				end if
				if myRightAlign is true then
					my myDrawGuide(myX2, vertical, myLayer, mySpread)
				end if
				if myXCenterAlign is true then
					my myDrawGuide(myXCenter, vertical, myLayer, mySpread)
				end if
				if myYCenterAlign is true then
					my myDrawGuide(myYCenter, horizontal, myLayer, mySpread)
				end if
			end repeat
		else
			repeat with myCounter from 1 to (count mySelection)
				--Get the bounds of the item (using geometric bounds if myBasedOn is 0, or visible bounds if it's 1)
				set myPageItem to item myCounter of mySelection
				if myBasedOn = 0 then
					set myBounds to geometric bounds of myPageItem
				else
					set myBounds to visible bounds of myPageItem
				end if
				--The following routine calculates the bounds of the entire selection by comparing
				--the bounds of individual objects.
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
			--Draw guides at the specified locations.
			if myTopAlign is true then
				my myDrawGuide(myY1, horizontal, myLayer, mySpread)
			end if
			if myLeftAlign is true then
				my myDrawGuide(myX1, vertical, myLayer, mySpread)
			end if
			if myBottomAlign is true then
				my myDrawGuide(myY2, horizontal, myLayer, mySpread)
			end if
			if myRightAlign is true then
				my myDrawGuide(myX2, vertical, myLayer, mySpread)
			end if
			if myXCenterAlign is true then
				my myDrawGuide(myXCenter, vertical, myLayer, mySpread)
			end if
			if myYCenterAlign is true then
				my myDrawGuide(myYCenter, horizontal, myLayer, mySpread)
			end if
		end if
		--Restore the ruler origin.
		set ruler origin of view preferences of myDocument to myOldRulerOrigin
	end tell
end myAddGuides
on myDrawGuidesAtPoints(myPageItem, myXPoint, myYPoint, myLayer, mySpread)
	tell application "Adobe InDesign 2024"
		repeat with myPathCounter from 1 to (count paths of myPageItem)
			repeat with myPointCounter from 1 to (count path points of path myPathCounter of myPageItem)
				set myAnchor to anchor of path point myPointCounter of path myPathCounter of myPageItem
				if myXPoint is true then
					my myDrawGuide(item 1 of myAnchor, vertical, myLayer, mySpread)
				end if
				if myYPoint is true then
					my myDrawGuide(item 2 of myAnchor, horizontal, myLayer, mySpread)
				end if
			end repeat
		end repeat
	end tell
end myDrawGuidesAtPoints
on myDrawGuide(myLocation, myGuideOrientation, myLayer, mySpread)
	tell application "Adobe InDesign 2024"
		tell mySpread
			set myGuide to make guide with properties {orientation:myGuideOrientation, location:myLocation, item layer:myLayer}
		end tell
	end tell
end myDrawGuide
