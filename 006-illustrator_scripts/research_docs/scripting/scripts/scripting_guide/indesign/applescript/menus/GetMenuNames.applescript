--GetMenuNames.applescript
--An InDesign AppleScript
--
--Gets the names of all menus and writes them to a text file.
--Open a new text file.
--set myTextFile to choose file name ("Save Menu Action Names As")
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Get menu names.]
	set myTextFile to choose file name {"Save Menu Names As"}
	--If the user clicked the Cancel button, the result is null.
	if (myTextFile is not equal to "") then
		tell application "Adobe InDesign 2024"
			--Open the file with write access.
			my myWriteToFile("Adobe InDesign CC Menu Names" & return, myTextFile, false)
			repeat with myCounter from 1 to (count menus)
				set myMenu to item myCounter of menus
				set myString to "----------" & return & name of myMenu & return & "----------" & return
				set myString to my myProcessMenu(myMenu, myString)
				my myWriteToFile(myString, myTextFile, true)
			end repeat
			display dialog ("done!")
		end tell
	end if
	--![Get menu names.]
end mySnippet
on myTeardown()
end myTeardown
--![Get menu names - functions.]
on myProcessMenu(myMenu, myString)
	tell application "Adobe InDesign 2024"
		set myIndent to my myGetIndent(myMenu)
		repeat with myCounter from 1 to (count menu elements of myMenu)
			set myMenuElement to menu element myCounter of myMenu
			set myClass to class of myMenuElement
			if myClass is not equal to menu separator then
				set myMenuElementName to name of myMenuElement
				set myString to myString & myIndent & myMenuElementName & return
				if class of myMenuElement is submenu then
					if myMenuElementName is not "Font" then
						set myString to my myProcessMenu(myMenuElement, myString)
					end if
				end if
			end if
		end repeat
		return myString
	end tell
end myProcessMenu
on myGetIndent(myObject)
	tell application "Adobe InDesign 2024"
		set myString to ""
		repeat until class of myObject is menu
			set myString to myString & tab
			set myObject to parent of myObject
		end repeat
		return myString
	end tell
end myGetIndent
on myWriteToFile(myString, myFileName, myAppendData)
	set myTextFile to open for access myFileName with write permission
	if myAppendData is false then
		set eof of myTextFile to 0
	end if
	write myString to myTextFile starting at eof
	close access myTextFile
end myWriteToFile
--![Get menu names - functions.]
