--TextImportPreferences.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Sets the text import filter preferences.
tell application "Adobe InCopy 2024"
	tell text import preferences
		--Options for character set:
		--ansi
		--chineseBig5
		--gb18030
		--gb2312
		--ksc5601
		--macintoshCE
		--macintoshCyrillic
		--macintoshGreek
		--macintoshTurkish
		--recommendShiftJIS83pv
		--shiftJIS90ms
		--shiftJIS90pv
		--unicode
		--windowsBaltic
		--windowsCE
		--windowsCyrillic
		--windowsEE
		--windowsGreek
		--windowsTurkish
		set character set to UTF16
		set convert spaces into tabs to true
		set spaces into tabs count to 3
		--The dictionary property can take any of the following
		--language names (as strings):
		--Bulgarian
		--Catalan
		--Croatian
		--Czech
		--Danish
		--Dutch
		--English:Canadian
		--English:UK
		--English:USA
		--English:USA Legal
		--English:USA Medical
		--Estonian
		--Finnish
		--French
		--French:Canadian
		--German:Reformed
		--German:Swiss
		--German:Traditional
		--Greek
		--Hungarian
		--Italian
		--Latvian
		--Lithuanian
		--Neutral
		--Norwegian:Bokmal
		--Norwegian:Nynorsk
		--Polish
		--Portuguese
		--Portuguese:Brazilian
		--Romanian
		--Russian
		--Slovak
		--Slovenian
		--Spanish:Castilian
		--Swedish
		--Turkish
		set dictionary to "English: USA"
		--platform options:
		--macintosh
		--pc
		set platform to macintosh
		set strip returns between lines to true
		set strip returns between paragraphs to true
		set use typographers quotes to true
	end tell
end tell
