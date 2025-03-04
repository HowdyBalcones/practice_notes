--GetScriptMenuActions.applescript
--An InDesign AppleScript
--
--Saves a list of the names of the current 
--script menu actions to a text file.
set myTextFile to choose file name {"Save Script Menu Action Names As"}
--If the user clicked the Cancel button, the result is null.
if myTextFile is not equal to "" then
	tell application "Adobe InDesign 2024"
		set myString to ""
		set myScriptMenuActionNames to name of every script menu action
		repeat with myScriptMenuActionName in myScriptMenuActionNames
			set myString to myString & myScriptMenuActionName & return
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
