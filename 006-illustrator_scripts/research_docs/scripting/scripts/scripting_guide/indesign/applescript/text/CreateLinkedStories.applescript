--CreateLinkedStories.applescript
--An InDesign AppleScript
--
--Creates a text frame containing the parent story in an example document,
--and then creates four text frames that link the parent story.
--Modify the parent story and update the text frames that link the parent story.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		tell document preferences of myDocument
			set facing pages to false
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		
		set myGeoBounds to my myGetBounds(myDocument, myPage)
		
		set originX to item 1 of myGeoBounds
		set originY to item 2 of myGeoBounds
		
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:{originY, originX, 100, 200}, contents:"This is the parent story."}
			
			--![Change linked story options.]
			tell linked story options of myDocument
				set remove forced line breaks to true
				set update while saving to true
				set warn on update of edited story to true
			end tell
			--![Change linked story options.]
			
			set childTextFrame1 to make text frame with properties {geometric bounds:{105, originX, 100 - originY + 105, 200}}
			set childTextFrame2 to make text frame with properties {geometric bounds:{100 - originY + 110, originX, 310 - originY * 2, 200}}
			set parentStory to parent story of myTextFrame
			
			--![Link existing text frame.]
			place and link childTextFrame1 parent story parentStory
			--![Link existing text frame.]
			
			place and link childTextFrame2 parent story parentStory
			
			--![Link page with story.]
			tell myDocument
				set myNewPage to make page
				tell myNewPage
					place and link parent story parentStory place point {originX, originY} without showing options
				end tell
			end tell
			--![Link page with story.]
			
			--![Link spread with story.]
			tell myDocument
				set myNewSpread to make spread
				tell myNewSpread
					place and link parent story parentStory place point {originX, originY} without showing options
				end tell
			end tell
			--![Link spread with story.]
			
			set contents of insertion point -1 of parentStory to "
This is a new paragraph of example text."
			
			set myLinks to links of myDocument
			
			repeat with i from 1 to count of myLinks
				set myLink to item i of myLinks
				set myFilePath to file path of myLink
				
				set filePath to file path of myLink
				set strLength to length of filePath
				if strLength = 0 then
					tell myLink to edit original
					
					if status of myLink = link out of date then
						tell myLink to update
					end if
				end if
			end repeat
			
		end tell
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

