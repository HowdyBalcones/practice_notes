--TextPreferences.applescript
--An InDesign AppleScript
--
--Sets text preferences.
--
--The following sets the text preferences for the application to set the
--text preferences for the front-most document, replace "text preferences" with
--"text preferences of document 1."
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
to mySetup()
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		--![Text preferences.]
		tell text preferences
			set abut text to text wrap to true
			--baseline shift key increment can range from .001 to 200 points.
			set baseline shift key increment to 1
			set highlight custom spacing to false
			set highlight hj violations to true
			set highlight keeps to true
			set highlight substituted fonts to true
			set highlight substituted glyphs to true
			set justify text wraps to true
			--kerning key increment value is 1/1000 of an em.
			set kerning key increment to 10
			--leading key increment value can range from .001 to 200 points.
			set leading key increment to 1
			set link text files when importing to false
			set show invisibles to true
			set small cap to 60
			set subscript position to 30
			set subscript size to 60
			set superscript position to 30
			set superscript size to 60
			set typographers quotes to false
			set use optical size to false
			set use paragraph leading to false
			set z order text wrap to false
		end tell
		--Text editing preferences are application-wide.
		tell text editing preferences
			set allow drag and drop text in story to true
			set drag and drop text in layout to true
			set smart cut and paste to true
			set triple click selects line to false
		end tell
		--![Text preferences.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
