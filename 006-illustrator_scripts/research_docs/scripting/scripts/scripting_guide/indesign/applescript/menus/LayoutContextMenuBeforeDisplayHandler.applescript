--LabelGraphicBeforeDisplay.applescript
--An InDesign AppleScript
--
--![Layout context menu before display handler.]
myBeforeDisplayHandler(evt)
on myBeforeDisplayHandler(myEvent)
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
					--Add the menu item if it does not already exist.
					if my myMenuItemExists(myLayoutContextMenu, "Label Graphic") is false then
						my myMakeLabelGraphicMenuItem(myLayoutContextMenu)
					end if
				else
					--Remove the menu item if it exists.
					if my myMenuItemExists(myLayoutContextMenu, "Label Graphic") is true then
						tell myLayoutContextMenu
							delete menu item "Label Graphic"
						end tell
					end if
				end if
			end if
		end if
	end tell
end myBeforeDisplayHandler
on myMakeLabelGraphicMenuItem(myLayoutContextMenu)
	tell application "Adobe InDesign 2024"
		if my myScriptMenuActionExists("Label Graphic") is false then
			set myEventHandler to my myFindFile("LabelGraphicOnInvoke.appleScript")
			set myLabelGraphicMenuAction to make script menu action with properties {name:"Label Graphic"}
			tell myLabelGraphicMenuAction
				set myLabelGraphicEventListener to make event listener with properties {event type:"onInvoke", handler:myEventHandler, captures:false}
			end tell
			
		else
			set myLabelGraphicMenuAction to script menu action "Label Graphic"
		end if
		tell myLayoutContextMenu
			set myLabelGraphicMenuItem to make menu item with properties {associated menu action:myLabelGraphicMenuAction}
		end tell
	end tell
end myMakeLabelGraphicMenuItem
--![Layout context menu before display handler.]
on myMenuItemExists(myMenu, myString)
	tell application "Adobe InDesign 2024"
		set myResult to true
		try
			set myMenuItem to menu item myString of myMenu
		on error
			set myResult to false
		end try
		return myResult
	end tell
end myMenuItemExists
on myScriptMenuActionExists(myString)
	tell application "Adobe InDesign 2024"
		set myResult to true
		try
			set myScriptMenuAction to script menu action myString
		on error
			set myResult to false
		end try
		return myResult
	end tell
end myScriptMenuActionExists
on myFindFile(myFindFileName)
	tell application "Adobe InDesign 2024"
		try
			set myScript to active script
		on error
			set myScript to path to me
		end try
	end tell
	tell application "Finder"
		set myScript to file myScript
		set myParentFolder to (container of myScript) as string
		set myFileName to myParentFolder & myFindFileName
		set myResult to exists myFileName
		if myResult is true then
		else
			set myFileName to choose file with prompt "Locate file: " & myFindFileName
		end if
	end tell
	return myFileName
end myFindFile
