--TextSelection.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to determine whether the current selection is a text selection.
--Check to see if any documents are open.
tell application "Adobe InCopy 2024"
	if (count documents) is not equal to 0 then
		set mySelection to selection
		if (count mySelection) is not equal to 0 then
			--Evaluate the selection based on its type.
			set myTextClasses to {insertion point, word, text style range, line, paragraph, text column, text, story}
			if class of item 1 of selection is in myTextClasses then
				--The object is a text object; display the text object type.
				--A practical script would do something with the selection,
				--or pass the selection on to a function.
				display dialog ("Selection is a text object.")
				--If the selection is inside a note, the parent of the selection
				--will be a note object.
				if class of parent of item 1 of selection is note then
					display dialog ("Selection is inside a note.")
				end if
			end if
		else
			display dialog ("Please select some text and try again.")
		end if
	else
		display dialog ("No documents are open.")
	end if
end tell


