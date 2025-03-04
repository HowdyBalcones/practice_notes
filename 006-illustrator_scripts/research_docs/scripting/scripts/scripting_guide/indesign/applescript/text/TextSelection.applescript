--TextSelection.applescript
--An InDesign AppleScript
--
--Shows how to determine whether the current selection is a text selection.
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
		--![Text selection.]
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
					display dialog ("Selection is a text object.")
					--If the selection is inside a note, the parent of the selection
					--will be a note object.
					if class of parent of item 1 of selection is note then
						display dialog ("Selection is inside a note.")
					end if
				else if class of item 1 of selection is text frame then
					display dialog ("Selection is a text frame")
				else
					display dialog ("Selected item is not a text object.")
				end if
			else
				display dialog ("Please select some text and try again.")
			end if
		else
			display dialog ("No documents are open.")
		end if
		--![Text selection.]
	end tell
end mySnippet
to myTeardown()
end myTeardown


