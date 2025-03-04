--ListScriptMenuActions.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Gets the names of all script menu actions 
--and writes them to a text file.
set myTextFile to choose file name {"Save Script Menu Action Names As"}
if myTextFile is not equal to "" then
	tell application "Adobe InCopy 2024"
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

