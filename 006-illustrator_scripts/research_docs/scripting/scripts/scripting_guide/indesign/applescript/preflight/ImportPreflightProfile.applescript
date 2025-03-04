--ImportPreflightProfile.applescript
--An InDesign AppleScript
--
--Shows how to import an InDesign preflight profile.

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
		--![Import preflight profile.]
		set myProfile to load preflight profile from "Macintosh HD:tmp:Test.idpp"
		if myProfile is nothing then
			display alert "The profile did not load successfully"
		else
			display alert "Preflight profile " & (name of myProfile) & " is loaded."
		end if
		--![Import preflight profile.]
	end tell
end mySnippet

on myTeardown()
end myTeardown
