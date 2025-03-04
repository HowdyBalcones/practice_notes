--TextExportPreferences.applescript
--An InCopy AppleScript
--
--Sets the text export filter preferences.
tell application "Adobe InCopy 2024"
	tell text export preferences
		--Options for character set:
		--UTF8
		--UTF16
		--default platform
		set character set to UTF16
		--platform options:
		--macintosh
		--pc
		set platform to macintosh
	end tell
end tell
