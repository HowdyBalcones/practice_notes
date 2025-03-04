--RemoveLabelGraphicMenu.applescript
--An InDesign AppleScript
--
--Removes the Layout context menu item "Label Graphic" (which was
--installed by the LabelGraphicMenu.applescript).
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--<fragment>
		set myLayoutContextMenu to menu "$ID/RtMouseLayout"
		set myResult to my myMenuItemExists(myLayoutContextMenu, "Label Graphic")
		if myResult is true then
			tell myLayoutContextMenu
				delete menu item "Label Graphic"
			end tell
		end if
		set myResult to my myScriptMenuActionExists("Label Graphic")
		if myResult is true then
			tell script menu action "Label Graphic" to delete
		end if
		tell myLayoutContextMenu
			set myEventHandler to my myFindFile("LabelGraphicBeforeDisplay.applescript")
			remove event listener event type "beforeDisplay" handler file myEventHandler without captures
			--</fragment>
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown
--<fragment>
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
--</fragment>
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
