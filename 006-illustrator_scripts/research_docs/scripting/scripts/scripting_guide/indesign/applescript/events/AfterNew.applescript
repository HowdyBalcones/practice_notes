--AfterNew.applescript
--An InDesign AppleScript
--
--Registers an event listener on the afterNew event.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![After new.]
		make event listener with properties {event type:"afterNew", handler:my myAfterNewHandler}
		--![After new.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--Provides an "afterNew" event handler that sets up a basic document 
--layout and adds XMP information to the document.
--<fragment>
on myAfterNewHandler()
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
			set document slug uniform size to false
			set slug bottom offset to mySlugOffset + mySlugHeight
			set slug top offset to 0
			set slug inside or left offset to 0
			set slug right or outside offset to 0
		end tell
		tell myDocument
			set myPageWidth to page width of document preferences
			set myPageHeight to page height of document preferences
		end tell
		repeat with myCounter from 1 to (count master spreads of myDocument)
			set myMasterSpread to master spread myCounter of myDocument
			repeat with myMasterPageCounter from 1 to (count pages of myMasterSpread)
				set myPage to page myMasterPageCounter of myMasterSpread
				set myLeft to left of margin preferences of myPage
				set myRight to right of margin preferences of myPage
				set myX1 to myLeft
				set myY1 to myPageHeight + mySlugOffset
				set myX2 to myPageWidth - myRight
				set myY2 to myY1 + mySlugHeight
				tell myPage
					set mySlugFrame to make text frame with properties {geometric bounds:{myY1, myX1, myY2, myX2}, contents:"Created: " & time stamp of evt & return & "by: " & myUserName}
				end tell
			end repeat
		end repeat
		tell metadata preferences of myDocument
			set author to "Adobe Systems"
			set description to "This is an example document containing XMP metadata. Created: " & time stamp of evt
		end tell
	end tell
end myAfterNewHandler
--</fragment>
