--SortParagraphs.applescript
--An InDesign AppleScript
--
--Sorts the selected paragraphs alphabetically.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
tell application "Adobe InDesign 2024"
	set myTextObjects to {text style range, paragraph, text column, text, story}
	if (count documents) > 0 then
		set mySelection to selection
		if (count mySelection) > 0 then
			if class of item 1 of mySelection is in myTextObjects then
				my mySortParagraphs()
			else
				display dialog "Text is not selected, or too little text is selected. Please select several paragraphs and try again."
			end if
		else
			display dialog "Nothing is selected. Please select some text and try again."
		end if
	else
		display dialog "No documents are open. Please open a document and try again."
	end if
end tell
on mySortParagraphs()
	set myDoCleanup to false
	tell application "Adobe InDesign 2024"
		set mySelection to selection
		set myText to item 1 of mySelection
		set myNumberOfParagraphs to (count paragraphs of myText)
		if myNumberOfParagraphs > 1 then
			set myStory to parent of myText
			set myStart to my myGetParagraphIndex(index of paragraph 1 of myText, myStory)
			set myEnd to my myGetParagraphIndex(index of paragraph -1 of myText, myStory)
			--If the last paragraph is at the end of the story, add a return to the end of the paragraph.
			set myLastCharacter to character -1 of paragraph -1 of myText
			if myLastCharacter is not return then
				set contents of insertion point -1 of paragraph -1 of myText to return
				set myDoCleanup to true
			end if
			my myBubbleSort(myStart, myEnd, myStory)
			--Deselect the sorted paragraphs.
			tell application "Adobe InDesign 2024"
				select nothing
			end tell
		end if
		if myDoCleanup is true then
			--Remove the carriage return at the end of the story
		end if
	end tell
end mySortParagraphs
on myGetParagraphIndex(myIndex, myStory)
	tell application "Adobe InDesign 2024"
		repeat with myCounter from 1 to (count paragraphs of myStory)
			set myStart to index of paragraph myCounter of myStory
			if myStart is equal to myIndex then
				return myCounter
			end if
		end repeat
	end tell
end myGetParagraphIndex
--Bubble sort for sorting paragraphs.
on myBubbleSort(myStart, myEnd, myStory)
	tell application "Adobe InDesign 2024"
		repeat
			set myItemMoved to false
			set myCounter to myStart
			repeat while myCounter is less than myEnd
				get myCounter
				if paragraph (myCounter) of myStory > paragraph (myCounter + 1) of myStory then
					tell paragraph myCounter of myStory
						move to after paragraph (myCounter + 1) of myStory
					end tell
					set myItemMoved to true
				end if
				set myCounter to myCounter + 1
			end repeat
			set myCounter to myEnd
			repeat while myCounter is greater than myStart
				if paragraph myCounter of myStory < paragraph (myCounter - 1) of myStory then
					tell paragraph myCounter of myStory
						move to before paragraph (myCounter - 1) of myStory
					end tell
					set myItemMoved to true
				end if
				set myCounter to myCounter - 1
			end repeat
			if myItemMoved is false then
				exit repeat
			end if
		end repeat
	end tell
end myBubbleSort
