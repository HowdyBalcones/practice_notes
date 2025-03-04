--LiquidLayout.applescript
--An InDesign AppleScript
--
--Shows how to set layout rule for document.
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
	--![Making a flexible layout.]
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		-- Set layout rule to object rule
		tell myPage
			--Reposition and resize objects on the page as it resizes.
			set layout rule to object based
			--Create a text frame on the first page.
			set myTextFrame to make text frame
			set geometric bounds of myTextFrame to my myGetBounds(myDocument, myPage)
			set contents of myTextFrame to "This is object based layoutrule sample doc."
			--Create a rectangle
			set myItem to make rectangle
			set geometric bounds of myItem to {20, 20, 70, 70}
			set vertical layout constraints of myItem to {flexible dimension, �
				flexible dimension, flexible dimension}
			set horizontal layout constraints of myItem to {fixed dimension, �
				flexible dimension, �
				flexible dimension}
		end tell
	end tell
	tell application "Adobe InDesign 2024"
		set myDocument2 to make document
		set myPage2 to page 1 of myDocument2
		-- Set layout rule to scale
		tell myPage2
			--Scale objects on the page as it resizes.
			set layout rule to scale
			--Create a text frame on the first page.
			set myTextFrame2 to make text frame
			set geometric bounds of myTextFrame2 to my myGetBounds(myDocument2, myPage2)
			set contents of myTextFrame2 to "This is scale layoutrule sample doc."
			set myItem2 to make rectangle
			set geometric bounds of myItem2 to {20, 20, 70, 70}
		end tell
	end tell
	tell application "Adobe InDesign 2024"
		set myDocument3 to make document
		set myPage3 to page 1 of myDocument3
		-- Set layout rule to recenter
		tell myPage3
			--Recenter objects on the page as it resizes.
			set layout rule to recenter
			--Create a text frame on the first page.
			set myTextFrame3 to make text frame
			set geometric bounds of myTextFrame3 to my myGetBounds(myDocument3, myPage3)
			set contents of myTextFrame3 to "This is recenter layoutrule sample doc."
			set myItem3 to make rectangle
			set geometric bounds of myItem3 to {20, 20, 70, 70}
		end tell
	end tell
	tell application "Adobe InDesign 2024"
		set myDocument4 to make document
		set myPage4 to page 1 of myDocument4
		-- Set layout rule to guide based
		tell myPage4
			--objects based on the page as it resizes.
			set layout rule to guide based
			--Create a text frame on the first page.
			set myTextFrame4 to make text frame
			set geometric bounds of myTextFrame4 to my myGetBounds(myDocument4, myPage4)
			set contents of myTextFrame4 to "This is guide based layoutrule sample doc."
			set myItem4 to make rectangle
			set geometric bounds of myItem4 to {20, 20, 70, 70}
			make guide with properties {orientation:horizontal, location:"20p", guide type:liquid}
		end tell
	end tell
	tell application "Adobe InDesign 2024"
		set myDocument5 to make document
		set myPage5 to page 1 of myDocument5
		-- Set layout rule to use master
		tell myPage5
			--Use master on the page as it resizes.
			set layout rule to use master
			--Create a text frame on the first page.
			set myTextFrame5 to make text frame
			set geometric bounds of myTextFrame5 to my myGetBounds(myDocument5, myPage5)
			set contents of myTextFrame5 to "This is master page layoutrule sample doc."
			set myItem5 to make rectangle
			set geometric bounds of myItem5 to {20, 20, 70, 70}
		end tell
	end tell
	--![Making a flexible layout.]
end mySnippet
--</snippet>
--<teardown>
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
