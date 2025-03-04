--InvokeMenuAction.applescript
--An InDesign AppleScript
--
--Shows how to run a menu action from a script.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
to mySnippet()
	tell application "Adobe InDesign 2024"
		set myTextObjects to {insertion point, word, text style range, line, paragraph, text column, text, story}
		if (count documents) > 0 then
			set mySelection to selection
			if (count mySelection) = 1 then
				if class of item 1 of mySelection is in myTextObjects then
					--![Invoke menu action.]
					--Get a reference to a menu action.
					set myMenuAction to menu action "$ID/NotesMenu_ConvertToNote"
					--Run the menu action. The example action will fail if you do not
					--have text selected.
					invoke myMenuAction
					--![Invoke menu action.]
				end if
			end if
		end if
	end tell
end mySnippet
on myTeardown()
end myTeardown
