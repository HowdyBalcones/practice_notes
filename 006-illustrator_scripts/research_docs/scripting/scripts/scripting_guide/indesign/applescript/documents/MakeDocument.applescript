--MakeDocument.applescript
--An InDesign AppleScript
--
--Creates a new document.
main()
to main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
end mySetup
--</setup>
--<snippet>
on mySnippet()
	--![Create a document.]
	--Creates a new document.
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
	--![Create a document.]
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>


