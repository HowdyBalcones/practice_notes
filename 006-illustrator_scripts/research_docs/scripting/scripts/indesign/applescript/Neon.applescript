--Neon.applescript
--An InDesign AppleScript
--
--Creates a "glow" effect by duplicating and formatting the selected objects.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or drop by the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
set myObjectList to {}
tell application "Adobe InDesign 2024"
	set myPageItemTypes to {rectangle, oval, polygon, graphic line}
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
--The following function takes care of displaying the dialog box.
on myDisplayDialog(myObjectList)
	set mySuppressedColorNames to {"Registration", "Cyan", "Magenta", "Yellow"}
	set myColorNames to {}
	set myLayerNames to {}
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		--Save the current measurement units.
		set myOldXUnits to horizontal measurement units of view preferences of myDocument
		set myOldYUnits to vertical measurement units of view preferences of myDocument
		--Set the current measurement units to points.
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		--Get a list of color names from the document.
		repeat with myCounter from 1 to (count colors of myDocument)
			set myColor to color myCounter of myDocument
			if name of myColor is not in mySuppressedColorNames and name of myColor is not "" then
				copy name of myColor to end of myColorNames
			end if
		end repeat
		if (count mixed inks of myDocument) > 0 then
			repeat with myCounter from 1 to (count mixed inks of myDocument)
				set myColor to mixed ink myCounter of myDocument
				if name of myColor is not "" then
					copy name of myColor to end of myColorNames
				end if
			end repeat
		end if
		--Get a list of the layer names from the document
		repeat with myCounter from 1 to (count layers of myDocument)
			copy name of layer myCounter of myDocument to end of myLayerNames
		end repeat
		copy "New Layer" to end of myLayerNames
		--Create the dialog box.
		set myDialog to make dialog with properties {name:"Neon"}
		tell myDialog
			tell (make dialog column)
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Number of Steps:"}
					end tell
					tell (make dialog column)
						set myNumberOfStepsField to make integer editbox with properties {edit value:12}
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"From:", min width:36}
					end tell
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Stroke Color:", min width:100}
							end tell
							tell (make dialog column)
								set myStrokeColorDropdown to make dropdown with properties {string list:myColorNames, selected index:0}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Stroke Weight:", min width:100}
							end tell
							tell (make dialog column)
								set myFromStrokeWeightField to make measurement editbox with properties {edit value:12, edit units:points}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Stroke Tint:", min width:100}
							end tell
							tell (make dialog column)
								set myFromStrokeTintField to make percent editbox with properties {edit value:100}
							end tell
						end tell
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"To:", min width:36}
					end tell
					tell (make dialog column)
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Stroke Weight:", min width:100}
							end tell
							tell (make dialog column)
								set myToStrokeWeightField to make measurement editbox with properties {edit value:0.25}
							end tell
						end tell
						tell (make dialog row)
							tell (make dialog column)
								make static text with properties {static label:"Stroke Tint:", min width:100}
							end tell
							tell (make dialog column)
								set myToStrokeTintField to make percent editbox with properties {edit value:0}
							end tell
						end tell
					end tell
				end tell
				tell (make border panel)
					tell (make dialog column)
						make static text with properties {static label:"Destination Layer:"}
					end tell
					tell (make dialog column)
						set myLayersDropdown to make dropdown with properties {string list:myLayerNames, selected index:1}
					end tell
				end tell
			end tell
		end tell
		--Display the dialog box.
		set myResult to show myDialog
		if myResult is true then
			--Get the values from the dialog box controls
			set myNumberOfSteps to edit value of myNumberOfStepsField
			set myStrokeColor to swatch ((item ((selected index of myStrokeColorDropdown) + 1)) of myColorNames) of myDocument
			set myFromStrokeWeight to edit value of myFromStrokeWeightField
			set myToStrokeWeight to edit value of myToStrokeWeightField
			set myFromStrokeTint to edit value of myFromStrokeTintField
			set myToStrokeTint to edit value of myToStrokeTintField
			set myLayerName to (item ((selected index of myLayersDropdown) + 1)) of myLayerNames
			--Remove the dialog box from memory.
			destroy myDialog
			my myNeon(myObjectList, myNumberOfSteps, myStrokeColor, myFromStrokeWeight, myToStrokeWeight, myFromStrokeTint, myToStrokeTint, myLayerName)
		else
			--Remove the dialog box from memory.
			destroy myDialog
		end if
		--Set the measurement units back to whatever they were before.
		set horizontal measurement units of view preferences of myDocument to myOldXUnits
		set vertical measurement units of view preferences of myDocument to myOldYUnits
	end tell
end myDisplayDialog
on myNeon(myObjectList, myNumberOfSteps, myStrokeColor, myFromStrokeWeight, myToStrokeWeight, myFromStrokeTint, myToStrokeTint, myLayerName)
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		tell myDocument
			if myLayerName = "New Layer" then
				set myLayer to make layer
			else
				set myLayer to layer myLayerName
			end if
		end tell
		set myTintIncrement to (myFromStrokeTint - myToStrokeTint) / myNumberOfSteps
		set myStrokeIncrement to (myFromStrokeWeight - myToStrokeWeight) / myNumberOfSteps
		repeat with myObjectCounter from 1 to (count myObjectList)
			set myObject to item myObjectCounter of myObjectList
			set myNeonItems to {}
			--Apply the "From" properties to the original object.
			tell myObject
				set stroke weight to myFromStrokeWeight
				set stroke color to myStrokeColor
				set stroke tint to myFromStrokeTint
				if (stroke tint of myObject) = -1 then
					set myStrokeTint to 100
				else
					set myStrokeTint to stroke tint of myObject
				end if
			end tell
			copy myObject to end of myNeonItems
			repeat with myCounter from 1 to myNumberOfSteps
				set myClone to (duplicate myObject)
				tell myClone to bring to front
				set stroke weight of myClone to ((stroke weight of myObject) - (myStrokeIncrement * myCounter))
				set stroke tint of myClone to (myStrokeTint - (myTintIncrement * myCounter))
				copy myClone to end of myNeonItems
			end repeat
			--Group the blend items.
			tell active spread of active window
				set myGroup to make group with properties {group items:myNeonItems}
			end tell
			--Assign the group to a layer.
			set item layer of myGroup to myLayer
		end repeat
	end tell
end myNeon
