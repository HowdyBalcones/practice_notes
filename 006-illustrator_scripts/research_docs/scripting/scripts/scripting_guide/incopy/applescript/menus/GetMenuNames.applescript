--GetMenuNames.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Gets the names of all menus and writes them to a text file.
--Open a new text file.
set myTextFile to choose file name ("Save Menu Names As")
--If the user clicked the Cancel button, the result is null.
if (myTextFile is not equal to "") then
	tell application "Adobe InCopy 2024"
		--Open the file with write access.
		my myWriteToFile("Adobe InCopy CS7 Menu Names" & return, myTextFile, false)
		repeat with myCounter from 1 to (count menus)
			set myMenu to item myCounter of menus
			set myString to "----------" & return & name of myMenu & return & "----------" & return
			set myString to my myProcessMenu(myMenu, myString)
			my myWriteToFile(myString, myTextFile, true)
		end repeat
		display dialog ("done!")
	end tell
end if
on myProcessMenu(myMenu, myString)
	tell application "Adobe InCopy 2024"
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
	tell application "Adobe InCopy 2024"
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

