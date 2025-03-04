--RemoveBeforeDisplay.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Removes the custom menu created by the BeforeDisplay.applescript
--tutorial script.
tell application "Adobe InCopy 2024"
	try
		set myScriptMenuAction to script menu action "Display Message"
		tell myScriptMenuAction
			delete
		end tell
		tell submenu "Script Menu Action" of menu "$ID/Main" to delete
	end try
end tell
