--UniformBleed.applescript
--An InDesign AppleScript
--
--Shows how to use the uniform size property of the document bleed.
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
	--Shows how to use the uniform size property of the document bleed.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Uniform bleed.]
		--The bleed properties belong to the document preferences object.
		--Given a document "myDocument"...
		tell document preferences of myDocument
			--Bleed
			set document bleed top offset to "2p"
			set document bleed uniform size to true
		end tell
		--![Uniform bleed.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
