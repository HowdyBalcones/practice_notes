--MakeTable.applescripttell application "Adobe InCopy 2024"tell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to create a table.
--
my main()
on main()
	my mySetup()
	my mySnippet()
end main
on mySetup()
	tell application "Adobe InCopy 2024"
		--Create an example document.
		set myDocument to make document
		set myStory to story 1 of myDocument
		set myString to "Table 1" & return
		set myString to "Column 1" & tab & "Column 2" & tab & "Column 3" & return
		set myString to myString & "1a" & tab & "1b" & tab & "1c" & return
		set myString to myString & "2a" & tab & "2b" & tab & "2c" & return
		set myString to myString & "3a" & tab & "3b" & tab & "3c" & return
		set myString to myString & "Table 2" & return
		set myString to myString & "Column 1,Column 2,Column 3;1a,1b,1c;2a,2b,2c;3a,3b,3c" & return
		set myString to myString & "Table 3" & return
		set contents of myStory to myString
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		tell myStory
			set myStartCharacter to index of character 1 of paragraph 7
			set myEndCharacter to index of character -2 of paragraph 7
			set myText to object reference of text from character myStartCharacter to character myEndCharacter
			--The convertToTable method takes three parameters:
			--[column separator as string]
			--[row separator as string]
			--[number of columns as integer] (only used if the column separator
			--and row separator values are the same)
			--In the last paragraph in the story, columns are separated by commas
			--and rows are separated by semicolons, so we provide those characters
			--to the method as parameters.
			tell myText
				set myTable to convert to table column separator "," row separator ";"
			end tell
			set myStartCharacter to index of character 1 of paragraph 2
			set myEndCharacter to index of character -2 of paragraph 5
			set myText to object reference of text from character myStartCharacter to character myEndCharacter
			--In the second through the fifth paragraphs, colums are separated by
			--tabs and rows are separated by returns. These are the default delimiter
			--parameters, so we don't need to provide them to the method.
			tell myText
				set myTable to convert to table column separator "	" row separator "
"
			end tell
			--You can also explicitly add a table--you don't have to convert text to a table.
			tell insertion point -1
				set myTable to make table
				set column count of myTable to 3
				set body row count of myTable to 3
			end tell
		end tell
	end tell
end mySnippet


