--RemoveEventListener.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to remove an event listener from the beforeNew event.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		--Properties of the event must match those of the event you want to remove.
		set myHandlerFile to my myFindFile("Message.applescript", "Locate the file message.applescript")
		remove event listener event type "beforeNew" handler file myHandlerFile without captures
	end tell
end mySnippet
on myTeardown()
end myTeardown
on myFindFile(myFindFileName, myPrompt)
	tell application "Adobe InCopy CS7"
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

