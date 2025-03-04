--AfterSelectionAttributeChanged.applescript
--An InDesign AppleScript
--
--Shows how to detect changes to the attributes of the selection. In this example,
--we'll check the fill and stroke color of the selection. If either property has been
--set to the "Registration" color, we'll display an alert when/if the attributes
--of the selection change.
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
		--![After selection attribute changed.]
		set myDocument to make document
		tell myDocument
			set myEventListener to make event listener with properties {event type:"afterSelectionAttributeChanged", handler:my myCheckForRegistration}
		end tell
		--![After selection attribute changed.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
--![After selection attribute changed - functions.]
on myCheckForRegistration()
	tell application "Adobe InDesign 2024"
		if (count documents) is greater than 0 then
			tell document 1
				set mySelection to selection
				if (count mySelection) is greater than 0 then
					set myRegistrationSwatchUsed to false
					repeat with myCounter from 1 to (count mySelection)
						set myFillColor to fill color of item myCounter of mySelection
						set myStrokeColor to stroke color of item myCounter of mySelection
						if name of myFillColor is "Registration" or name of myStrokeColor is "Registration" then
							set myRegistrationSwatchUsed to true
						end if
					end repeat
					if myRegistrationSwatchUsed is true then
						display dialog "The Registration swatch is applied to some of the" & return & "objects in the selection. Did you really intend to apply this swatch?"
					end if
				end if
			end tell
		end if
	end tell
end myCheckForRegistration
![After selection attribute changed - functions.]
