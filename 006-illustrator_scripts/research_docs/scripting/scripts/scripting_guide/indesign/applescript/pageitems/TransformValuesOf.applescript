--CatenateMatrix.applescript
--An InDesign AppleScript
--
--Shows how to use the transform values of method.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Transform values.]
		--Given a document with a rectangle on page 1...
		set myRectangle to rectangle 1 of page 1 of document 1
		--Note that transform values of always returns a list containing a single transformation matrix.
		set myTransformArray to transform values of myRectangle in pasteboard coordinates
		set myTransformationMatrix to item 1 of myTransformArray
		set myRotationAngle to counterclockwise rotation angle of myTransformationMatrix
		set myShearAngle to clockwise shear angle of myTransformationMatrix
		set myXScale to horizontal scale factor of myTransformationMatrix
		set myYScale to vertical scale factor of myTransformationMatrix
		set myXTranslate to horizontal translation of myTransformationMatrix
		set myYTranslate to vertical translation of myTransformationMatrix
		set myString to "Rotation Angle: " & myRotationAngle & return
		set myString to myString & "Shear Angle: " & myShearAngle & return
		set myString to myString & "Horizontal Scale Factor: " & myXScale & return
		set myString to myString & "Vertical Scale Factor: " & myYScale & return
		set myString to myString & "Horizontal Translation: " & myXTranslate & return
		set myString to myString & "Vertical Translation: " & myYTranslate & return & return
		set myString to myString & "Note that the Horizontal Translation and" & return
		set myString to myString & "Vertical Translation values are the location" & return
		set myString to myString & "of the center anchor in pasteboard coordinates."
		display dialog (myString)
		--![Transform values.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myDocument to make document
		set when scaling of transform preferences to adjust scaling percentage
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
