--DocumentPresetByExample.applescript
--An InDesign AppleScript
--
--Creates a new document preset based on the current document settings.
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
	tell application "Adobe InDesign 2024"
		if (count documents) > 0 then
			set myDocument to document 1
			--![Creating a preset by example.]
			--Given a document "myDocument"...
			--If the document preset "myDocumentPreset" does not already exist, create it.	
			try
				set myDocumentPreset to document preset "myDocumentPreset"
			on error
				set myDocumentPreset to make document preset with properties {name:"myDocumentPreset"}
			end try
			--Fill in the properties of the document preset with the corresponding
			--properties of the active document.
			tell myDocumentPreset
				--Note that the following gets the page margins from the margin preferences
				--of the document; to get the margin preferences from the active page,
				--replace "myDocument" with "active page of active window" in the
				--following line (assuming the active window is a layout window).
				set myMarginPreferences to margin preferences of myDocument
				set left to left of myMarginPreferences
				set right to right of myMarginPreferences
				set top to top of myMarginPreferences
				set bottom to bottom of myMarginPreferences
				set column count to column count of myMarginPreferences
				set column gutter to column gutter of myMarginPreferences
				set document bleed bottom offset to document bleed bottom offset of document preferences of myDocument
				set document bleed top offset to document bleed top offset of document preferences of myDocument
				set document bleed inside or left offset to document bleed inside or left offset of document preferences of myDocument
				set document bleed outside or right offset to document bleed outside or right offset of document preferences of myDocument
				set facing pages to facing pages of document preferences of myDocument
				set page height to page height of document preferences of myDocument
				set page width to page width of document preferences of myDocument
				set page orientation to page orientation of document preferences of myDocument
				set pages per document to pages per document of document preferences of myDocument
				set slug bottom offset to slug bottom offset of document preferences of myDocument
				set slug top offset to slug top offset of document preferences of myDocument
				set slug inside or left offset to slug inside or left offset of document preferences of myDocument
				set slug right or outside offset to slug right or outside offset of document preferences of myDocument
			end tell
			--![Creating a preset by example.]
		end if
	end tell
end mySnippet
on myTeardown()
end myTeardown
