--TaggedTextExportPreferences.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Sets the tagged text export filter preferences.
tell application "Adobe InCopy 2024"
	tell tagged text export preferences
		--Options for character set:
		--ansi
		--ascii
		--gb18030
		--ksc5601
		--shiftJIS
		--unicode
		set character set to unicode
		--tag form options:
		--abbreviated
		--verbose
		set tag form to verbose
	end tell
end tell
