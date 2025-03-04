-- RotatedSpreads.applescript
-- An InDesign AppleScript
-- 
-- Shows how to rotate spreads in a document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set ruler origin of view preferences to page origin
			set pages per document of document preferences to 6
			set myMasterSpread to master spread 1
			tell myMasterSpread
				repeat with myCounter from 1 to (count pages)
					tell page myCounter
						set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, page myCounter of myMasterSpread), contents:auto page number}
						set point size of text 1 of myTextFrame to 72
						set justification of text 1 of myTextFrame to center align
						set vertical justification of text frame preferences of myTextFrame to center align
					end tell
				end repeat
			end tell
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		-- Spread.transform (in: CoordinateSpaces , from:any, withMatrix:any, replacingCurrent:any, consideringRulerUnits: Boolean ) 
		-- <fragment>
		-- Given a document containing at least two spreads, rotate the second spread 90 degrees counterclockwise. 
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:90}
		tell spread 2 of myDocument
			transform in pasteboard coordinates from center anchor with matrix myTransformationMatrix
		end tell
		-- </fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown

on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
