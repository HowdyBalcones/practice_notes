--ListPreflightProfiles.applescript
--An InDesign AppleScript
--
--Shows how to list all InDesign preflight profiles.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
end mySetup

on mySnippet()
	--![List preflight profiles.]
	tell application "Adobe InDesign 2024"
		set myProfiles to preflight profiles
		set myProfileCount to count of myProfiles
		set myStr to "Preflight profiles: "
		repeat with i from 1 to myProfileCount
			if i > 1 then
				set myStr to myStr & ", "
			end if
			set myStr to myStr & name of item i of myProfiles
		end repeat
		display alert myStr
	end tell
	--![List preflight profiles.]
end mySnippet

on myTeardown()
end myTeardown
