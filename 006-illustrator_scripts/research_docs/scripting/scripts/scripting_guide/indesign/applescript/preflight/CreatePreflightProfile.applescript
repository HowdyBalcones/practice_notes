--CreatePreflightProfile.applescript
--An InDesign AppleScript
--
--Shows how to create an InDesign preflight profile.

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
		--![Create preflight profile.]
		--Add a new preflight profile.
		set myProfile to make preflight profile
		display alert "Preflight profile " & (name of myProfile) & " is created."
		--Rename the profile
		tell myProfile
			set oldName to name
			set name to "Test"
			set description to "Test description"
		end tell
		display alert "Profile " & oldName & " is renamed to " & (name of myProfile) & "."
		--![Create preflight profile.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
