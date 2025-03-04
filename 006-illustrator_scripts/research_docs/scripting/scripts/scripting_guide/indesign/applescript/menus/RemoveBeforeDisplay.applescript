--RemoveBeforeDisplay.applescript
--An InDesign AppleScript
--
--Shows how to remove the submenu and script menu item created
--by the BeforeDisplay.applescript tutorial script.
--Note that you might have to force InDesign to redraw the menu
--(by switching out of the application and back again) to make
--the menu item appear on the main menu bar.
tell application "Adobe InDesign 2024"
	--<fragment>
	try
		set myScriptMenuAction to script menu action "Display Message"
		tell myScriptMenuAction to delete
	end try
	try
		set mySampleScriptMenu to submenu "Script Menu Action" of menu ("$ID/Main")
		tell mySampleScriptMenu to delete
	end try
	--</fragment>
end tell
