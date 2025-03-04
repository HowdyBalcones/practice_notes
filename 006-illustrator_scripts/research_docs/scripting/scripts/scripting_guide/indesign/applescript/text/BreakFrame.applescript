--BreakFrame.applescript
--An InDesign AppleScript
--
--Removes the selected text frame (or text frames) from the
--story containing the text frame and removes the text contained
--by the text frame from the story.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Break frame.]
	set myObjectList to {}
	--Script does nothing if no documents are open or if no objects are selected.
	tell application "Adobe InDesign 2024"
		if (count documents) is not equal to 0 then
			set mySelection to selection
			if (count mySelection) is not equal to 0 then
				--Process the objects in the selection to create a list of
				--qualifying objects (text frames).
				repeat with myCounter from 1 to (count mySelection)
					if class of item myCounter of mySelection is text frame then
						set myObjectList to myObjectList & item myCounter of mySelection
					else if class of item myCounter of mySelection is in {text, insertion point, character, word, line, text style range, paragraph, text column} then
						set myObject to item 1 of parent text frames of item myCounter of mySelection
						set myObjectList to myObjectList & myObject
					end if
				end repeat
				--If the object list is not empty, pass it on to the handler
				--that does the real work.
				if (count myObjectList) is not equal to 0 then
					my myBreakFrames(myObjectList)
				end if
			end if
		end if
	end tell
	--![Break frame.]
end mySnippet
on myTeardown()
end myTeardown
--![Break frame - functions.]
on myBreakFrames(myObjectList)
	repeat with myCounter from 1 to (count myObjectList)
		my myBreakFrame(item myCounter of myObjectList)
	end repeat
end myBreakFrames
on myBreakFrame(myTextFrame)
	tell application "Adobe InDesign 2024"
		if next text frame of myTextFrame is not equal to nothing and previous text frame of myTextFrame is not equal to nothing then
			set myNewFrame to duplicate myTextFrame
			if contents of myTextFrame is not equal to "" then
				tell text 1 of myTextFrame to delete
			end if
			delete myTextFrame
		end if
	end tell
end myBreakFrame
--![Break frame - functions.]
