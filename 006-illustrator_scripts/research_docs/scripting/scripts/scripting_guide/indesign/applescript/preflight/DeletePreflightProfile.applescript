--DeletePreflightProfile.applescript
--An InDesign AppleScript
--
--Shows how to delete an InDesign preflight profile.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
end mySetup

on mySnippet()
	removeProfile("Test")
end mySnippet

on myTeardown()
end myTeardown

--![Delete preflight profile.]
on removeProfile(profileName)
	tell application "Adobe InDesign 2024"
		set myProfiles to preflight profiles
		set profileCount to count of myProfiles
		repeat with i from 1 to profileCount
			if name of item i of myProfiles is equal to profileName then
				delete item i of myProfiles
			end if
		end repeat
	end tell
end removeProfile
--![Delete preflight profile.]
