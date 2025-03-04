--BeforeDisplay.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to create a beforeDisplay event listener to a menu item.
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
		--Create the script menu action "Display Message" if it does not already exist.
		try
			set myScriptMenuAction to script menu action "Display Message"
		on error
			set myScriptMenuAction to make script menu action with properties {title:"Display Message"}
		end try
		tell myScriptMenuAction
			--If the script menu action already existed, 
			--remove the existing event listeners.
			if (count event listeners) > 0 then
				tell every event listener to delete
			end if
			set myFileName to my myFindFile("WhatIsSelected.applescript", "Locate the file WhatIsSelected.applecript")
			if myFileName is not "" then
				make event listener with properties {event type:"onInvoke", handler:myFileName}
			else
				display dialog "onInvoke handler file not found"
			end if
		end tell
		set myFileName to my myFindFile("BeforeDisplayHandler.applescript", "Locate the file BeforeDisplayHandler.applescript")
		if myFileName is not "" then
			tell menu "$ID/Main"
				set mySampleScriptMenu to make submenu with properties {title:"Script Menu Action"}
				tell mySampleScriptMenu
					set mySampleScriptMenuItem to make menu item with properties {associated menu action:myScriptMenuAction}
					make event listener with properties {event type:"beforeDisplay", handler:myFileName}
				end tell
				make event listener with properties {event type:"onInvoke", handler:myFileName}
			end tell
		else
			display dialog "beforeDisplay handler file not found"
		end if
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

