--BeforeDisplay.applescript
--An InDesign AppleScript
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
	tell application "Adobe InDesign 2024"
		--![Before display.]
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
			--You'll have to fill in your own file path.
			make event listener with properties {event type:"onInvoke", handler:"yukino:IDEventHandlers:WhatIsSelected.applescript"}
		end tell
		tell menu "$ID/Main"
			set mySampleScriptMenu to make submenu with properties {title:"Script Menu Action"}
			tell mySampleScriptMenu
				set mySampleScriptMenuItem to make menu item with properties {associated menu action:myScriptMenuAction}
				make event listener with properties {event type:"beforeDisplay", handler:"yukino:IDEventHandlers:BeforeDisplayHandler.applescript"}
			end tell
		end tell
		--![Before display.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
