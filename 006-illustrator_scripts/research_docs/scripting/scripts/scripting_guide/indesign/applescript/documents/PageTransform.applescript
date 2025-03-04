--PageTransform.applescript
--An InDesign AppleScript
--
--A brief demonstration of the page transform method.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		--Create a new document.
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
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
		--![Transform page.]
		--Given a document with four pages (1, 2, 3, 4)...
		set myDocument to active document
		set myPages to pages of myDocument
		
		--Rotate a page around its center point.
		set myRotateMatrix to make transformation matrix with properties {counterclockwise rotation angle:27}
		my myTransform(item 1 of myPages, myRotateMatrix)
		
		--Scale a page around its center point.
		set myScaleMatrix to make transformation matrix with properties {horizontal scale factor:0.8, vertical scale factor:0.8}
		my myTransform(item 2 of myPages, myScaleMatrix)
		
		--Shear a page around its center point.
		set myShearMatrix to make transformation matrix with properties {clockwise shear angle:30}
		my myTransform(item 3 of myPages, myShearMatrix)
		--![Transform page.]
	end tell
end mySnippet

on myTeardown()
end myTeardown

--![Transform page - functions.]
on myTransform(myPage, myTransformationMatrix)
	tell application "Adobe InDesign 2024"
		transform myPage in pasteboard coordinates from center anchor with matrix myTransformationMatrix
	end tell
end myTransform
--![Transform page - functions.]
