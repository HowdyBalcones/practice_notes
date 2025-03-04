--RemoveCustomMenu.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Removes the custom menu created by the CustomMenu.applescript
--tutorial script.
tell application "Adobe InCopy 2024"
	try
		tell submenu "Kozuka Mincho Pro" of menu "$ID/Main" to delete
	end try
end tell
