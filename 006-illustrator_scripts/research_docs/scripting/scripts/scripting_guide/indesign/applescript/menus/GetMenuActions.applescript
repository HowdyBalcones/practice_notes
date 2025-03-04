--GetMenuActions.applescript
--An InDesign AppleScript
--
--Writes the names of all menu actions to a text file.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Get menu actions.]
	set myTextFile to choose file name ("Save menu action names as:")
	if myTextFile is not equal to "" then
		tell application "Adobe InDesign 2024"
			set myString to ""
			set myMenuActionNames to name of every menu action
			repeat with myMenuActionName in myMenuActionNames
				set myString to myString & myMenuActionName & return
			end repeat
			my myWriteToFile(myString, myTextFile, false)
		end tell
	end if
	--![Get menu actions.]
end mySnippet
on myTeardown()
end myTeardown
--![Get menu actions - functions.]
on myWriteToFile(myString, myFileName, myAppendData)
	set myTextFile to open for access myFileName with write permission
	if myAppendData is false then
		set eof of myTextFile to 0
	end if
	write myString to myTextFile starting at eof
	close access myTextFile
end myWriteToFile
--![Get menu actions - functions.]
