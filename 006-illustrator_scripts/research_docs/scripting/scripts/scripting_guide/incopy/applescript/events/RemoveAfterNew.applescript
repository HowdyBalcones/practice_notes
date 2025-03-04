--RemoveAfterNew.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Removes the event listener installed by the AfterNew.applescript script.
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
		set myHandlerFile to my myFindFile("AfterNewHandler.applescript", "Locate the file AfterNewHandler.applescript")
		remove event listener event type "after" handler file myHandlerFile with captures
	end tell
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

