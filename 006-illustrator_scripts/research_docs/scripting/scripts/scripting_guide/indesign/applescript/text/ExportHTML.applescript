--ExportHTML.applescript
--An InDesign AppleScript
--
--Exports the text in a document as HTML by traversing the stories in
--the document and writing the text to disk as HTML markup.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		--Create an example document.
		set myDocument to make document
		tell myDocument
			--Create example paragraph styles
			set myHeading1Style to my myMakeParagraphStyle(myDocument, "heading1")
			set point size of myHeading1Style to 24
			set myHeading2Style to my myMakeParagraphStyle(myDocument, "heading2")
			set point size of myHeading2Style to 16
			set myHeading3Style to my myMakeParagraphStyle(myDocument, "heading3")
			set point size of myHeading3Style to 12
			set myBodyTextStyle to my myMakeParagraphStyle(myDocument, "body_text")
			set point size of myBodyTextStyle to 10
			set myPage to page 1
			tell myPage
				set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
			end tell
			set myStory to parent story of myTextFrame
			--Fill the story with example text.
			set myString to "Heading 1" & return
			set myString to myString & "This is a normal paragraph." & return
			set myString to myString & "Heading 2" & return
			set myString to myString & "This is another normal paragraph." & return
			set myString to myString & "Heading 3" & return
			set myString to myString & "This is yet another normal paragraph." & return
			set myString to myString & "Column 1" & tab & "Column 2" & tab & "Column 3" & return
			set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
			set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
			set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
			set contents of myStory to myString
			tell paragraph 1 of myStory to apply paragraph style using myHeading1Style clearing overrides yes
			tell paragraph 2 of myStory to apply paragraph style using myBodyTextStyle clearing overrides yes
			tell paragraph 3 of myStory to apply paragraph style using myHeading2Style clearing overrides yes
			tell paragraph 4 of myStory to apply paragraph style using myBodyTextStyle clearing overrides yes
			tell paragraph 5 of myStory to apply paragraph style using myHeading3Style clearing overrides yes
			tell paragraph 6 of myStory to apply paragraph style using myBodyTextStyle clearing overrides yes
			set font style of word 4 of paragraph 2 of myStory to "Bold"
			set font style of word 3 of paragraph 4 of myStory to "Italic"
			set myStartCharacter to index of character 1 of paragraph 7 of myStory
			set myEndCharacter to index of character -2 of myStory
			set myText to object reference of text from character myStartCharacter to character myEndCharacter of myStory
			tell myText
				set myTable to convert to table
			end tell
			set myRow to row 1 of myTable
			set row type of myRow to header row
		end tell
	end tell
end mySetup
on myMakeParagraphStyle(myDocument, myStyleName)
	tell application "Adobe InDesign 2024"
		try
			set myStyle to paragraph style myStyleName of myDocument
		on error
			tell myDocument
				set myStyle to make paragraph style with properties {name:myStyleName}
			end tell
		end try
		return myStyle
	end tell
end myMakeParagraphStyle
on mySnippet()
	--![Export HTML.]
	tell application "Adobe InDesign 2024"
		--Use the myStyleToTagMapping array to set up your paragraph style to tag mapping.
		set myStyleToTagMapping to {}
		--For each style to tag mapping, add a new item to the array.
		copy {"body_text", "p"} to end of myStyleToTagMapping
		copy {"heading1", "h1"} to end of myStyleToTagMapping
		copy {"heading2", "h3"} to end of myStyleToTagMapping
		copy {"heading3", "h3"} to end of myStyleToTagMapping
		--End of style to tag mapping.
		if (count documents) is not equal to 0 then
			set myDocument to document 1
			if (count stories of myDocument) is not equal to 0 then
				--Open a new text file.
				set myTextFile to choose file name with prompt "Save HTML As"
				--Iterate through the stories.
				repeat with myCounter from 1 to (count stories of myDocument)
					set myStory to story myCounter of myDocument
					repeat with myParagraphCounter from 1 to (count paragraphs of myStory)
						set myParagraph to object reference of paragraph myParagraphCounter of myStory
						if (count tables of myParagraph) is 0 then
							--If the paragraph is a simple paragraph--no tables, no local formatting--then
							--simply export the text of the pararaph with the appropriate tag.
							if (count text style ranges of myParagraph) is 1 then
								set myTag to my myFindTag(name of applied paragraph style of myParagraph, myStyleToTagMapping)
								--If the tag comes back empty, map it to the basic paragraph tag.
								if myTag = "" then
									set myTag to "p"
								end if
								set myStartTag to "<" & myTag & ">"
								set myEndTag to "</" & myTag & ">"
								--If the paragraph is not the last paragraph in the story,
								--omit the return character.
								if the contents of character -1 of myParagraph is return then
									set myText to object reference of text from character 1 to character -2 of myParagraph
									set myString to contents of myText
								else
									set myString to contents of myParagraph
								end if
								--Write the text of the paragraph to the text file.
								if myParagraphCounter = 1 then
									set myAppendData to false
								else
									set myAppendData to true
								end if
								my myWriteToFile(myStartTag & myString & myEndTag & return, myTextFile, myAppendData)
							else
								--Handle text style range export by iterating through the text style ranges in the paragraph.
								set myTextStyleRanges to text style ranges of myParagraph
								repeat with myRangeCounter from 1 to (count text style ranges of myParagraph)
									set myTextStyleRange to object reference of text style range myRangeCounter of myParagraph
									if character -1 of myTextStyleRange is return then
										set myStartCharacter to index of character 1 of myTextStyleRange
										set myEndCharacter to index of character -2 of myTextStyleRange
										set myText to object reference of text from character myStartCharacter to character myEndCharacter of myStory
										set myString to contents of myText
									else
										set myString to contents of myTextStyleRange
									end if
									if font style of myTextStyleRange is "Bold" then
										set myString to "<b>" & myString & "</b>"
									else if font style of myTextStyleRange is "Italic" then
										set myString to "<i>" & myString & "</i>"
									end if
									my myWriteToFile(myString, myTextFile, true)
								end repeat
								my myWriteToFile(return, myTextFile, true)
							end if
						else
							--Handle table export (assumes that there is only one table per paragraph,
							--and that the table is in the paragraph by itself).
							set myTable to table 1 of myParagraph
							my myWriteToFile("<table border = 1>", myTextFile, true)
							repeat with myRowCounter from 1 to (count rows of myTable)
								my myWriteToFile("<tr>", myTextFile, true)
								repeat with myColumnCounter from 1 to (count columns of myTable)
									if myRowCounter = 1 then
										set myString to "<th>"
										set myString to myString & text 1 of cell myColumnCounter of row myRowCounter of myTable
										set myString to myString & "</th>"
									else
										set myString to "<td>"
										set myString to myString & text 1 of cell myColumnCounter of row myRowCounter of myTable
										set myString to myString & "</td>"
									end if
									my myWriteToFile(myString, myTextFile, true)
								end repeat
								my myWriteToFile("</tr>" & return, myTextFile, true)
							end repeat
							my myWriteToFile("</table>" & return, myTextFile, true)
						end if
					end repeat
				end repeat
			end if
		end if
	end tell
	--![Export HTML.]
end mySnippet
on myTeardown()
end myTeardown
--![Export HTML - functions.]
on myFindTag(myStyleName, myStyleToTagMapping)
	local myTag, myDone, myStyleName
	set myTag to ""
	set myDone to false
	repeat with myStyleToTagMap in myStyleToTagMapping
		if item 1 of myStyleToTagMap = myStyleName then
			set myTag to item 2 of myStyleToTagMap
			exit repeat
		end if
	end repeat
	return myTag
end myFindTag
on myWriteToFile(myString, myFileName, myAppendData)
	set myTextFile to open for access myFileName with write permission
	if myAppendData is false then
		set eof of myTextFile to 0
	end if
	write myString to myTextFile starting at eof
	close access myTextFile
end myWriteToFile
--![Export HTML - functions.]
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
