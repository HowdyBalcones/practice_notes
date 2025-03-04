--TranslateKeyString.applescript
--An InCopy AppleScript
--
--Displays the localized string corresponding to a key string (the
--locale-independent version of an object name).
tell application "Adobe InCopy 2024"
	--Enter the key string you want to translate in the following line.
	set myString to translate key string for "$ID/Convert to Note"
	display dialog (myString)
end tell
