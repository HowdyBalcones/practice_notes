--MultipleEventListeners.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows that an event can trigger multiple event listeners.
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
		set myDocument to make document
		--The application-level handler will display a simple message; the 
		--document-level handler will display a more complex message.
		--Both handlers will be triggered by the same event.
		set myApplicationHandlerFile to my myFindFile("Message.applescript", "Locate the file message.applescript")
		set myDocumentHandlerFile to my myFindFile("GetEventInfo.applescript", "Locate the file GetEventInfo.applescript")
		make event listener with properties {event type:"beforeImport", handler:myApplicationHandlerFile, captures:false}
		tell myDocument
			make event listener with properties {event type:"beforeImport", handler:myDocumentHandlerFile, captures:false}
		end tell
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

