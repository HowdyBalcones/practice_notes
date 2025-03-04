--BreakFrame.applescript
--An InDesign AppleScript
--
--Removes the selected text frame (or text frames) from the
--story containing the text frame and removes the text contained
--by the text frame from the story.
--
--If you want to split *all* of the text fames in the story, use the
--SplitStory.as script.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--Or visit the InDesign Scripting User to User forum at http://www.adobeforums.com.
--
set myObjectList to {}
--Script does nothing if no documents are open or if no objects are selected.
tell application "Adobe InDesign 2024"
	set myTextObjects to {text, text frame, insertion point, character, word, text style range, line, paragraph, text column}
	if (count documents) is not 0 then
		--Process the objects in the selection to create a list of
		--qualifying objects (text frames).
		set mySelection to selection
		if (count mySelection) is not 0 then
			repeat with myCounter from 1 to (count mySelection)
				if class of item myCounter of mySelection is in myTextObjects then
					copy item myCounter of mySelection to end of myObjectList
				end if
			end repeat
			if (count myObjectList) is greater than 0 then
				my myBreakFrames(myObjectList)
			end if
		end if
	end if
end tell
on myBreakFrames(myObjectList)
	tell application "Adobe InDesign 2024"
		repeat with myObject in myObjectList
			if class of myObject is not text frame then
				set myObject to item 1 of parent text frames of myObject
			end if
			tell myObject to duplicate
			tell text 1 of myObject to delete
			tell myObject to delete
		end repeat
	end tell
end myBreakFrames
