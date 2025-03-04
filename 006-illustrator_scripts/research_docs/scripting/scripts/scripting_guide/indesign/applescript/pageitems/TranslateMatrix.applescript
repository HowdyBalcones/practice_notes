--TranslateMatrix.applescript
--An InDesign AppleScript
--
--Shows how to use the translate matrix method.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--<fragment>
		--Given a rectangle on page 1...
		set myRectangle to rectangle 1 of page 1 of document 1
		set myTransformationMatrix to make transformation matrix
		--translateMatrix takes two parameters: horizontallyBy and verticallyBy
		set myTransformationMatrix to translate matrix myTransformationMatrix horizontally by 72 vertically by 0
		transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		--</fragment>
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
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
