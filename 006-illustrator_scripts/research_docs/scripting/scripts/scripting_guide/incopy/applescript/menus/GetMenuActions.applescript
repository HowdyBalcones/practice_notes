--GetMenuActions.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Gets the names of all menu actions and writes them to a text file.
set myTextFile to choose file name {"Save Menu Action Names As"}
--If the user clicked the Cancel button, the result is null.
if myTextFile is not equal to "" then
	tell application "Adobe InCopy 2024"
		set myString to ""
		set myMenuActionNames to name of every menu action
		repeat with myMenuActionName in myMenuActionNames
			set myString to myString & myMenuActionName & return
		end repeat
		my myWriteToFile(myString, myTextFile, false)
	end tell
end if
on myWriteToFile(myString, myFileName, myAppendData)
	set myTextFile to open for access myFileName with write permission
	if myAppendData is false then
		set eof of myTextFile to 0
	end if
	write myString to myTextFile starting at eof
	close access myTextFile
end myWriteToFile

