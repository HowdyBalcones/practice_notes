--ContentCollectorAndPlacer.applescript
--An InDesign AppleScript
--
--Use content placer to load page items in one document and place them to another document
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
--<setup>
on mySetup()
	--Create a new document
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell document preferences of myDocument
			set page width to "600pt"
			set page height to "800pt"
			set pages per document to 1
		end tell
	end tell
	--Create another new document
	tell application "Adobe InDesign 2024"
		set myDocument1 to make document
		tell document preferences of myDocument1
			set page width to "600pt"
			set page height to "800pt"
			set pages per document to 1
		end tell
	end tell
end mySetup
--</setup>
--<snippet>
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		set myDocument1 to document 2
		set myPage1 to page 1 of myDocument1
		tell myPage
			--Create a textframe
			set myTextFrame to make text frame
			set geometric bounds of myTextFrame to {"15p", "15p", "25p", "50p"}
			set contents of myTextFrame to "I am a text frame"
			--Create a checkbox
			set myCheckBox to make check box
			set geometric bounds of myCheckBox to {"5p", "5p", "10p", "10p"}
			set name of myCheckBox to "I am a check box"
			--Create a button
			set myButton to make button
			set geometric bounds of myButton to {"45p", "15p", "35p", "35p"}
			set name of myButton to "I am a button"
			--Create a rectangle frame
			set myRectangle to make rectangle
			set geometric bounds of myRectangle to {"45p", "75p", "35p", "45p"}
			set name of myRectangle to "I am a rectangle"
			--Create an oval frame
			set myOval to make oval
			set geometric bounds of myOval to {"75p", "15p", "50p", "35p"}
			set name of myOval to "I am an oval"
			--Create a polygon frame
			set myPolygon to make polygon
			set name of myPolygon to "I am a polygon"
			set myPath to path 1 of myPolygon
			set entire path of myPath to {{"12p", "12p"}, {"22p", "22p"}, {"32p", "12p"}}
		end tell
		
		--Need to save the document before invoking Page.contentPlace
		set myDesktopFolder to path to desktop as string
		set myFile to myDesktopFolder & "ContentCollectorAndPlacer.indd"
		tell document 1 to save to myFile
		--Invoke Page.contentPlace to load page items of myDocument and place them into myDocument1
		--<fragment>
		--Invoke Page.contentPlace with default parameters
		tell myPage1
			content place page items text frames of myPage
		end tell
		--</fragment>
		--![Placing content.]
		--Invoke Page.contentPlace with full parameters
		tell myPage1
			content place page items check boxes of myPage 
				with link page items, link stories, map styles and showing options
		end tell
		--![Placing content.]
		--<fragment>
		--Invoke load with default parameters, then invoke Page.contentPlace with default parameters
		tell content placer object 1
			load page items myOval
		end tell
		--Need to save the document before invoking Page.contentPlace
		set myFile to myDesktopFolder & "ContentCollectorAndPlacer.indd"
		tell document 1 to save to myFile
		--invoke Page.contentPlace with default parameters
		tell myPage1
			content place page items ovals of myPage
		end tell
		--</fragment>
		--<fragment>
		--Invoke load with default parameters, then invoke Page.contentPlace with full parameters
		tell content placer object 1
			load page items myButton
		end tell
		--Need to save the document before invoking Page.contentPlace
		set myFile to myDesktopFolder & "ContentCollectorAndPlacer.indd"
		tell document 1 to save to myFile
		--invoke Page.contentPlace with full parameters
		tell myPage1
			content place page items buttons of myPage 
				with link page items, link stories, map styles and showing options
		end tell
		--</fragment>
		--![Collecting content.]
		--Invoke load with full parameters, then invoke Page.contentPlace with default parameters
		tell content placer object 1
			load page items myPolygon 
				with link page items, link stories, map styles and showing options
		end tell
		--![Collecting content.]
		--Need to save the document before invoking Page.contentPlace
		set myFile to myDesktopFolder & "ContentCollectorAndPlacer.indd"
		tell document 1 to save to myFile
		--invoke Page.contentPlace with default parameters
		tell myPage1
			content place page items polygons of myPage
		end tell
		--</fragment>
		--<fragment>
		--Invoke load with full parameters, then invoke Page.contentPlace with full parameters
		tell content placer object 1
			load page items myRectangle �
				with link page items, link stories, map styles and showing options
		end tell
		--Need to save the document before invoking Page.contentPlace
		set myFile to myDesktopFolder & "ContentCollectorAndPlacer.indd"
		tell document 1 to save to myFile
		--invoke Page.contentPlace with full parameters
		tell myPage1
			content place page items rectangles of myPage �
				with link page items, link stories, map styles and showing options
		end tell
		--</fragment>
	end tell
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>