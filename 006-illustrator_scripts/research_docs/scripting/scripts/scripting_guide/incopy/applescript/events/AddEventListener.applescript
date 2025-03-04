--AddEventListener.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to add an event listener to the
--beforeNew event.
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
		set myHandlerFileName to my myFindFile("Message.applescript", "Locate the file message.applescript")
		set myEventListener to make event listener with properties {event type:"beforeNew", handler:myHandlerFileName, captures:false}
	end tell
	--</fragment>
end mySnippet
on myTeardown()
end myTeardown
--<fragment>
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
--</fragment>

