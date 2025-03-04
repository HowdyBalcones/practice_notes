--FindChangeGlyph.applescript
--An InCopy AppleScript
--
--Demonstrates the find glyph and change glyph features.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
--Setup Help Text
--Setup help text goes here.
--end setup help text
--
on mySetup()
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		set myStory to story 1 of myDocument
		set myString to "This is an example paragraph containing a specific glyph: " & �data utxt25A0� & "." & return
		set myString to myString & "This is a paragraph containing a specific glyph: " & �data utxt25A0� & "." & return
		set myString to myString & "This is another paragraph containing a specific glyph: " & �data utxt25A0� & "." & return
		set contents of myStory to myString
	end tell
end mySetup
--Snippet Help Text
--Snippet help text goes here.
--end snippet help text
--
on mySnippet()
	tell application "Adobe InCopy 2024"
		--Clear glyph search preferences.
		set find glyph preferences to nothing
		set change glyph preferences to nothing
		set myDocument to document 1
		--You must provide a font that is used in the document for the
		--applied font property of the find glyph preferences object.
		set applied font of find glyph preferences to applied font of character 1 of story 1 of myDocument
		--Provide the glyph ID, not the glyph Unicode value.
		set glyph ID of find glyph preferences to 500
		--The applied font of the change glyph preferences object can be
		--any font available to the application.
		set applied font of change glyph preferences to "Times New Roman	Regular"
		set glyph ID of change glyph preferences to 374
		tell myDocument
			change glyph
		end tell
		--Clear glyph search preferences.
		set find glyph preferences to nothing
		set change glyph preferences to nothing
	end tell
end mySnippet
