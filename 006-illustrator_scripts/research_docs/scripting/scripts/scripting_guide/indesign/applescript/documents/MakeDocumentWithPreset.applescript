--MakeDocument.applescript
--An InDesign AppleScript
--
--Creates a new document using a specified preset.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
	--Creates a document preset if it does not already exist.
	tell application "Adobe InDesign 2024"
		--If the document preset "myDocumentPreset" does not already exist, create it.	
		try
			set myDocumentPreset to document preset "myDocumentPreset"
		on error
			set myDocumentPreset to make document preset with properties {name:"myDocumentPreset"}
		end try
		--Fill in the properties of the document preset.
		tell myDocumentPreset
			set page height to "9i"
			set page width to "7i"
			set left to "4p"
			set right to "6p"
			set top to "4p"
			set bottom to "9p"
			set column count to 1
			set document bleed bottom offset to "3p"
			set document bleed top offset to "3p"
			set document bleed inside or left offset to "3p"
			set document bleed outside or right offset to "3p"
			set facing pages to true
			set page orientation to portrait
			set pages per document to 1
			set slug bottom offset to "18p"
			set slug top offset to "3p"
			set slug inside or left offset to "3p"
			set slug right or outside offset to "3p"
		end tell
	end tell
end mySetup
--</setup>
--<snippet>
on mySnippet()
	--![Create a document with preset.]
	tell application "Adobe InDesign 2024"
		--Replace "myDocumentPreset" in the following line with the name 
		--of the document preset you want to use.
		set myDocument to make document with properties {document preset:"myDocumentPreset"}
	end tell
	--![Create a document with preset.]
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>

