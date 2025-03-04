--BleedAndSlug.applescript
--An InDesign AppleScript
--
--Shows how to define the bleed and slug areas of a document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Shows how to define the bleed and slug areas of a document.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Bleed and slug.]
		--The bleed and slug properties belong to the document preferences object.
		tell document preferences of myDocument
			--Bleed
			set document bleed bottom offset to "3p"
			set document bleed top offset to "3p"
			set document bleed inside or left offset to "3p"
			set document bleed outside or right offset to "3p"
			--Slug
			set slug bottom offset to "18p"
			set slug top offset to "3p"
			set slug inside or left offset to "3p"
			set slug right or outside offset to "3p"
		end tell
		--![Bleed and slug.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
