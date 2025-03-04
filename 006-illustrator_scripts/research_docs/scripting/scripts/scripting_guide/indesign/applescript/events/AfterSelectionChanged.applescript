--AfterSelectionChanged.applescript
--An InDesign AppleScript
--
--Shows how to detect changes to the selection.
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
		--Add an event listener that displays the type of the objects in the selection.
		--![After selection changed.]
		set myDocument to make document
		tell myDocument
			set myEventListener to make event listener with properties {event type:"afterSelectionChanged", handler:my myDisplaySelectionType}
		end tell
		--![After selection changed.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![After selection changed - functions.]
on myDisplaySelectionType(en)
	tell application "Adobe InDesign 2024"
		if (count documents) is greater than 0 then
			tell document 1
				set mySelection to selection
				if (count mySelection) is greater than 0 then
					set myString to "Selection Contents:" & return
					repeat with myCounter from 1 to (count mySelection)
						set myString to myString & class of item myCounter of mySelection & return
					end repeat
					display dialog myString
				end if
			end tell
		end if
	end tell
end myDisplaySelectionType
--![After selection changed - functions.]
