--AddGuides.applescript
--An InDesign AppleScript
--
--Shows how to add guide slice for guide based layout rule.
main()
on main()
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
	--![Add guides.]
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		tell myPage
			set layout rule to guide based
			set myTextFrame to make text frame
			--Set the bounds of the text frame.
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
			--Enter text in the text frame.
			set contents of myTextFrame to "This is guide-based layoutrule sample doc."
			set myItem to make rectangle
			set geometric bounds of myItem to {20, 20, 70, 70}
		end tell
		tell myPage
			make guide with properties {orientation:horizontal, location:"20p", guide type:liquid}
		end tell
	end tell
	--![Add guides.]
end mySnippet
--</snippet>
--<teardown>
on myTeardown()
end myTeardown
--</teardown>
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
