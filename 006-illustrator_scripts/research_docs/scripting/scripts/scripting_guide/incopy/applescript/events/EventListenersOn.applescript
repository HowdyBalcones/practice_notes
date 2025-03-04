--EventListenersOn.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Turns on all event listeners on the application object.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--<fragment>
	tell application "Adobe InCopy 2024"
		set myEventNames to {"beforeNew", "afterNew", "beforeQuit", "afterQuit", "beforeOpen", "afterOpen", "beforeClose", "afterClose", "beforeSave", "afterSave", "beforeSaveAs", "afterSaveAs", "beforeSaveACopy", "afterSaveACopy", "beforeRevert", "afterRevert", "beforePrint", "afterPrint", "beforeExport", "afterExport", "beforeImport", "afterImport", "beforePlace", "afterPlace"}
		set myHandlerFile to my myFindFile("GetEventInfo.applescript", "Locate the file GetEventInfo.applescript")
		repeat with myEventName in myEventNames
			make event listener with properties {event type:myEventName, handler:myHandlerFile, captures:false}
		end repeat
	end tell
	--</fragment>
end mySnippet
on myTeardown()
end myTeardown
on myFindFile(myFindFileName, myPrompt)
	tell application "Adobe InCopy 2024"
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
			set myFileName to choose file with prompt myPrompt
		end if
	end tell
	return myFileName
end myFindFile

