--UniformSlug.applescript
--An InDesign AppleScript
--
--Shows how to use the uniform size property of the document slug area.
main()
to main()
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
	--Shows how to use the uniform size property of the document slug
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Uniform slug.]
		--The slug properties belong to the document preferences object.
		--Given a document "myDocument"...
		tell document preferences of myDocument
			--Bleed
			set slug top offset to "4p"
			set document slug uniform size to true
		end tell
		--![Uniform slug.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
