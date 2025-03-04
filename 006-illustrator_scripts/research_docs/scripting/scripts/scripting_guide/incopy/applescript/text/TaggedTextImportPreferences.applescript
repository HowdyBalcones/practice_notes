--TaggedTextImportPreferences.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Sets the tagged text import filter preferences.
tell application "Adobe InCopy 2024"
	tell tagged text import preferences
		set remove text formatting to false
		--Options for style conflict are:
		--publication definition
		--tag file definition
		set style conflict to publication definition
		set use typographers quotes to true
	end tell
end tell
