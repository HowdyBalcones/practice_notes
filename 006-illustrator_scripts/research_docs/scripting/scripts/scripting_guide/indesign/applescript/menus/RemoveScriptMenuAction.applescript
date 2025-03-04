--RemoveScriptMenuAction.applescript
--An InDesign AppleScript
--
--Removes a custom menu from the main menu bar.
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
		--![Remove script menu action.]
		try
			set myScriptMenuAction to script menu action "Display Message"
			tell myScriptMenuAction
				delete
			end tell
			tell submenu "Script Menu Action" of menu "$ID/Main" to delete
		end try
		--![Remove script menu action.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

