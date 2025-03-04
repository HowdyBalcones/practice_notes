--LabelGraphicOnInvoke.applescript
--An InDesign AppleScript
--
--
--Provides an "onInvoke" event handler for the LabelGraphicMenu
--example script. Adds a label to the selected graphic(s).
--<fragment>
LabelGraphicEventHandler(evt)
on LabelGraphicEventHandler(myEvent)
	tell application "Adobe InDesign 2024"
		set myGraphicList to {PDF, EPS, image}
		set myParentList to {rectangle, oval, polygon}
		set myContainerList to {page, spread, group, rectangle, oval, polygon}
		set myObjectList to {}
		set myLayoutContextMenu to menu "$ID/RtMouseLayout"
		if (count documents) > 0 then
			set mySelection to selection
			if (count mySelection) > 0 then
				repeat with myCounter from 1 to (count mySelection)
					set myObject to item myCounter of mySelection
					if class of myObject is in myGraphicList then
						--Do not add the graphic to the list if it is in an inline
						--or anchored frame.
						if class of parent of parent of myObject is in myContainerList then
							copy myObject to end of myObjectList
						end if
					else if class of myObject is in myParentList then
						--Do not add the graphic to the list if it is in an inline
						--or anchored frame.
						if class of parent of myObject is in myContainerList then
							if (count graphics of myObject) > 0 then
								copy graphic 1 of myObject to end of myObjectList
							end if
						end if
					end if
				end repeat
				if (count myObjectList) is not equal to 0 then
					--The selection contains a qualifying item or items.
					my myDisplayDialog(myObjectList)
				end if
			end if
		end if
	end tell
end LabelGraphicEventHandler
--Displays a dialog box containing label options.
on myDisplayDialog(myObjectList)
	tell application "Adobe InDesign 2024"
		set myLabelWidth to 100
		set myStyleNames to my myGetParagraphStyleNames(document 1)
		set myLayerNames to my myGetLayerNames(document 1)
		set myDialog to make dialog with properties {name:"LabelGraphic"}
		tell myDialog
			tell (make dialog column)
				--Label Type
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Label Type:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myLabelTypeDropdown to make dropdown with properties {string list:{"File Name", "File Path", "XMP Author", "XMP Description"}, selected index:0}
					end tell
				end tell
				--Text frame height
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Label Height:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myLabelHeightField to make measurement editbox with properties {edit value:24, edit units:points}
					end tell
				end tell
				--Text frame offset
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Label Offset:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myLabelOffsetField to make measurement editbox with properties {edit value:0, edit units:points}
					end tell
				end tell
				--Paragraph style to apply
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Label Style:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myLabelStyleDropdown to make dropdown with properties {string list:myStyleNames, selected index:0}
					end tell
				end tell
				--Layer
				tell (make dialog row)
					tell (make dialog column)
						make static text with properties {static label:"Layer:", min width:myLabelWidth}
					end tell
					tell (make dialog column)
						set myLayerDropdown to make dropdown with properties {string list:myLayerNames, selected index:0}
					end tell
				end tell
			end tell
		end tell
		set myResult to show myDialog
		if myResult is true then
			set myLabelType to (selected index of myLabelTypeDropdown)
			set myLabelHeight to edit value of myLabelHeightField
			set myLabelOffset to edit value of myLabelOffsetField
			set myLabelStyleName to item ((selected index of myLabelStyleDropdown) + 1) of myStyleNames
			set myLayerName to item ((selected index of myLayerDropdown) + 1) of myLayerNames
			destroy myDialog
			tell view preferences of document 1
				set myOldXUnits to horizontal measurement units
				set myOldYUnits to vertical measurement units
				set horizontal measurement units to points
				set vertical measurement units to points
			end tell
			repeat with myCounter from 1 to (count myObjectList)
				set myGraphic to item myCounter of myObjectList
				my myAddLabel(myGraphic, myLabelType, myLabelHeight, myLabelOffset, myLabelStyleName, myLayerName)
			end repeat
			tell view preferences of document 1
				set horizontal measurement units to myOldXUnits
				set vertical measurement units to myOldYUnits
			end tell
		else
			destroy myDialog
		end if
	end tell
end myDisplayDialog

on myAddLabel(myGraphic, myLabelType, myLabelHeight, myLabelOffset, myLabelStyleName, myLayerName)
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myLabelStyle to paragraph style myLabelStyleName of myDocument
		try
			set myLabelLayer to layer myLayerName of myDocument
		on error
			tell myDocument
				set myLabelLayer to make layer with properties {name:myLayerName}
			end tell
		end try
		set myLink to item link of myGraphic
		if myLabelType is 0 then
			set myLabel to name of myLink
		else if myLabelType is 1 then
			set myLabel to file path of myLink
		else if myLabelType is 2 then
			try
				set myLabel to author of link xmp of myLink
			on error
				set myLabel to "No author available."
			end try
		else if myLabelType is 3 then
			try
				set myLabel to description of link xmp of myLink
			on error
				set myLabel to "No description available."
			end try
		end if
		set myFrame to parent of myGraphic
		set myBounds to geometric bounds of myFrame
		set myX1 to item 2 of myBounds
		set myY1 to (item 3 of myBounds) + myLabelOffset
		set myX2 to item 4 of myBounds
		set myY2 to myY1 + myLabelHeight
		tell parent of myFrame
			set myTextFrame to make text frame with properties {item layer:myLabelLayer, contents:myLabel, geometric bounds:{myY1, myX1, myY2, myX2}}
			set first baseline offset of text frame preferences of myTextFrame to leading offset
			tell myTextFrame
				set applied paragraph style of paragraph 1 to myLabelStyle
			end tell
		end tell
	end tell
end myAddLabel
--Returns a list of paragraph style names.
on myGetParagraphStyleNames(myDocument)
	tell application "Adobe InDesign 2024"
		set myParagraphStyleNames to name of every paragraph style of myDocument
		return myParagraphStyleNames
	end tell
end myGetParagraphStyleNames
--Returns a list of layer names.
on myGetLayerNames(myDocument)
	set myLayerNames to {}
	set myAddLayerName to true
	tell application "Adobe InDesign 2024"
		repeat with myLayer in layers of myDocument
			copy name of myLayer to end of myLayerNames
			if name of myLayer is "Labels" then
				set myAddLayerName to false
			end if
		end repeat
		if myAddLayerName is true then
			copy "Labels" to end of myLayerNames
		end if
		return myLayerNames
	end tell
end myGetLayerNames
--</fragment>
