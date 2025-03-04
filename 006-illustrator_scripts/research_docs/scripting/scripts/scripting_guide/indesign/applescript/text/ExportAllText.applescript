--ExportAllText.applescript
--An InDesign AppleScript
--
--Exports all of the text in the active document as a single
--text file. To do this, the script will create a new document,
--combine the stories in the new document using export/import,
--and then export the text from the new document.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Export all text.]
	tell application "Adobe InDesign 2024"
		if (count documents) > 0 then
			set myDocument to active document
			if (count stories of myDocument) > 0 then
				my myExportAllText(name of myDocument)
			end if
		end if
	end tell
	--![Export all text.]
end mySnippet
on myTeardown()
end myTeardown
--![Export all text - functions.]
on myExportAllText(myDocumentName)
	tell application "Adobe InDesign 2024"
		--File name for the exported text. Fill in a valid file path on your system.
		set myFileName to "Adobe:test.txt"
		--If you want to add a separator line between stories, set myAddSeparator to true.
		set myAddSeparator to true
		set myNewDocument to make document
		set myDocument to document myDocumentName
		tell page 1 of myNewDocument
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myNewDocument, page 1 of myNewDocument)}
			set myNewStory to parent story of myTextFrame
			repeat with myCounter from 1 to (count stories in myDocument)
				set myStory to story myCounter of myDocument
				--Duplicate the text of the story to the end of the temporary story.
				tell text 1 of myStory
					duplicate to after insertion point -1 of story 1 of myNewDocument
				end tell
				--If the imported text did not end with a return, enter a return
				--to keep the stories from running together.
				if myCounter is not equal to (count stories of myDocument) then
					if contents of character -1 of myNewStory is not return then
						set contents of insertion point -1 of myNewStory to return
						if myAddSeparator is true then
							set contents of insertion point -1 of myNewStory to "----------------------------------------" & return
						end if
					end if
				end if
			end repeat
			tell myNewStory
				export to myFileName format text type
			end tell
			close myNewDocument saving no
		end tell
	end tell
end myExportAllText
--![Export all text - functions.]
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
