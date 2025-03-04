--SplitStory.applescript
--An InDesign AppleScript
--
--Splits all of the text frames in the selected story
--or stories into separate text frames.
set myIDList to {}
set myStoryList to {}
--Script does nothing if no documents are open or if no objects are selected.
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
		if (count documents) is not equal to 0 then
			set mySelection to selection
			if (count mySelection) is not equal to 0 then
				--Process the objects in the selection to create a list of
				--qualifying objects (text frames).
				repeat with myCounter from 1 to (count mySelection)
					if class of item myCounter of mySelection is text frame then
						set myParentStory to parent story of item myCounter of mySelection
						if id of myParentStory is not in myIDList then
							set myIDList to myIDList & id of myParentStory
							set myStoryList to myStoryList & myParentStory
						end if
					else if class of item myCounter of mySelection is in {text, insertion point, character, word, line, text style range, paragraph, text column} then
						set myParentStory to parent story of item myCounter of mySelection
						if id of myParentStory is not in myIDList then
							set myIDList to myIDList & id of myParentStory
							set myStoryList to myStoryList & myParentStory
						end if
					end if
				end repeat
				--If the object list is not empty, pass it on to the handler
				--that does the real work.
				if (count myStoryList) is not equal to 0 then
					my mySplitStories(myStoryList)
				end if
			end if
		end if
	end tell
end mySnippet
on myTeardown()
end myTeardown
on mySplitStories(myStoryList)
	repeat with myCounter from 1 to (count myStoryList)
		my mySplitStory(item myCounter of myStoryList)
	end repeat
end mySplitStories
--![Split story.]
on mySplitStory(myStory)
	tell application "Adobe InDesign 2024"
		tell document 1
			local myTextContainers
			set myTextContainers to text containers in myStory
			if (count myTextContainers) is greater than 1 then
				repeat with myCounter from (count myTextContainers) to 1 by -1
					set myTextFrame to item myCounter of myTextContainers
					tell myTextFrame
						duplicate
						if text 1 of myTextFrame is not equal to "" then
							tell text 1 of myTextFrame
								delete
							end tell
						end if
						delete
					end tell
				end repeat
			end if
		end tell
	end tell
end mySplitStory
--![Split story.]
