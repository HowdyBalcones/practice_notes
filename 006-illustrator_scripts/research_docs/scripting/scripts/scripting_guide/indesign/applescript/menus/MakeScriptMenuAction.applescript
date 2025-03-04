--MakeScriptMenuAction.applescript
--An InDesign AppleScript
--
--Adds a custom menu to the main menu bar.
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
		--![Make script menu action.]
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
			set myEventListener to make event listener with properties {event type:"onInvoke", handler:"yukino:message.applescript"}
		end tell
		tell menu "$ID/Main"
			set mySampleScriptMenu to make submenu with properties {title:"Script Menu Action"}
			tell mySampleScriptMenu
				set mySampleScriptMenuItem to make menu item with properties {associated menu action:myScriptMenuAction}
			end tell
		end tell
		--![Make script menu action.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
