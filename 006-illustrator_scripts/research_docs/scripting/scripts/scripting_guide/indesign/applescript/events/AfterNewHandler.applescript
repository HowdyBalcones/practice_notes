--AfterNewHandler.applescript
--An InDesign AppleScript
--
--![After new handler.]
--Provides an "afterNew" event handler for the AfterNew.applescript
--tutorial script. Sets up a basic document layout and adds XMP information
--to the document.
--
myAfterNewHandler(evt)
on myAfterNewHandler(myEvent)
	tell application "Adobe InDesign 2024"
		if user name = "" then
			set user name to "Adobe"
		end if
		set myUserName to user name
		--set myDocument to parent of myEvent
		set myDocument to document 1
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			set ruler origin to page origin
		end tell
		--MySlugOffset is the distance from the bottom of the page
		--to the top of the slug.
		set mySlugOffset to 12
		--MySlugHeight is the height of the text frame
		--containing the job information.
		set mySlugHeight to 72
		tell document preferences of myDocument
			set slug bottom offset to mySlugOffset + mySlugHeight
			set slug top offset to 0
			set slug inside or left offset to 0
			set slug right or outside offset to 0
		end tell
		repeat with myCounter from 1 to (count master spreads of myDocument)
			set myMasterSpread to master spread myCounter of myDocument
			repeat with myMasterPageCounter from 1 to (count pages of myMasterSpread)
				set myPage to page myMasterPageCounter of myMasterSpread
				set mySlugBounds to my myGetSlugBounds(myDocument, myPage, mySlugOffset, mySlugHeight)
				tell myPage
					set mySlugFrame to make text frame with properties {geometric bounds:mySlugBounds, contents:"Created: " & time stamp of myEvent & return & "by: " & myUserName}
				end tell
			end repeat
		end repeat
		tell metadata preferences of myDocument
			set author to "Adobe Systems"
			set description to "This is an example document containing XMP metadata. Created: " & time stamp of myEvent
		end tell
	end tell
end myAfterNewHandler
on myGetSlugBounds(myDocument, myPage, mySlugOffset, mySlugHeight)
	tell application "Adobe InDesign 2024"
		tell myDocument
			set myPageWidth to page width of document preferences
			set myPageHeight to page height of document preferences
		end tell
		set myLeft to left of margin preferences of myPage
		set myRight to right of margin preferences of myPage
		set myX1 to myLeft
		set myY1 to myPageHeight + mySlugOffset
		set myX2 to myPageWidth - myRight
		set myY2 to myY1 + mySlugHeight
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetSlugBounds
--![After new handler.]