--MasterPageTransform.applescript
--An InDesign AppleScript
--
--A brief demonstration of the master page overlay transformation.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set show master page overlay of general preferences to true
		
		--Create a new document.
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		set point size of text defaults of myDocument to 36
		
		--Write some text on master pages.
		tell item 1 of master spreads of myDocument
			make text frame in item 1 of pages with properties {geometric bounds:{36, 36, 108, 576}, contents:"Text on left page of " & name}
			make text frame in item 2 of pages with properties {geometric bounds:{36, 648, 108, 1188}, contents:"Text on right page of " & name}
		end tell
		
		--Create another 3 pages.
		tell myDocument
			repeat with i from 2 to 4
				make page
			end repeat
		end tell
	end tell
end mySetup

on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Master page overlay.]
		--Given a document with four pages (1, 2, 3, 4)...
		set myDocument to active document
		set myPages to pages of myDocument
		
		--Rotate master page overlay around its top-left corner.
		set myRotateMatrix to make transformation matrix with properties {counterclockwise rotation angle:27}
		set master page transform of item 1 of myPages to myRotateMatrix
		
		--Scale master page overlay around its top-left corner.
		set myScaleMatrix to make transformation matrix with properties {horizontal scale factor:0.5, vertical scale factor:0.5}
		set master page transform of item 2 of myPages to myScaleMatrix
		
		--Shear master page overlay around its top-left corner.
		set myShearMatrix to make transformation matrix with properties {clockwise shear angle:30}
		set master page transform of item 3 of myPages to myShearMatrix
		
		--Translate master page overlay 1 inch right and 2 inches down.
		set myTranslateMatrix to make transformation matrix with properties {horizontal translation:72, vertical translation:144}
		set master page transform of item 4 of myPages to myTranslateMatrix
		--![Master page overlay.]
	end tell
end mySnippet

on myTeardown()
end myTeardown

