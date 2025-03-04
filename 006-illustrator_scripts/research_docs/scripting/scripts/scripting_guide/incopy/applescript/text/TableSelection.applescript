--TableSelection.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to determine if the selection is in a table.
--
--Check to see if any documents are open.
tell application "Adobe InCopy 2024"
	if (count documents) is not equal to 0 then
		--If the selection contains more than one item, the selection
		--is not text selected with the Type tool.
		set mySelection to selection
		if (count mySelection) is not equal to 0 then
			--Evaluate the selection based on its type.
			set myTextClasses to {insertion point, word, text style range, line, paragraph, text column, text, story}
			if class of item 1 of selection is in myTextClasses then
				--The object is a text object; display the text object type.
				--A practical script would do something with the selection,
				--or pass the selection on to a function.
				if class of parent of item 1 of mySelection is cell then
					display dialog ("The selection is inside a table cell")
				else
					display dialog ("The selection is not in a table")
				end if
			else if class of item 1 of selection is cell then
				display dialog ("The selection is a table cell")
			else if class of item 1 of selection is row then
				display dialog ("The selection is a table row")
			else if class of item 1 of selection is column then
				display dialog ("The selection is a table column")
			else if class of item 1 of selection is table then
				display dialog ("The selection is a table.")
			else
				display dialog ("The selection is not in a table")
			end if
		end if
	end if
end tell
