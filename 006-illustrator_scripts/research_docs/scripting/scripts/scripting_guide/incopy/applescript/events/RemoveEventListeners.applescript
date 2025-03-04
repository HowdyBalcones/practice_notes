--RemoveEventListeners.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Removes the event listeners installed by the MultipleEventListeners script.
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
		--Properties of the event must match those of the event you want to remove.
		set myHandlerFile to my myFindFile("Message.applescript", "Locate the file message.applescript")
		set myResult to remove event listener event type "beforeImport" handler file myHandlerFile with captures
		if myResult is true then
			display dialog "Application event listener removed."
		end if
		if (count documents) is not 0 then
			tell document 1
				set myHandlerFile to my myFindFile("GetEventInfo.applescript", "Locate the file GetEventInfo.applescript")
				set myResult to remove event listener event type "beforeImport" handler file myHandlerFile without captures
				if myResult is true then
					display dialog "Document event listener removed."
				else
					display dialog "Document event listener not removed."
				end if
			end tell
		end if
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

