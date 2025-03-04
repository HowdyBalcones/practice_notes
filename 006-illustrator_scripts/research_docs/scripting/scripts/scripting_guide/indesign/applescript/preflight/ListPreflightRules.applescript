--ListPreflightRules.applescript
--An InDesign AppleScript
--
--Shows how to list all InDesign preflight rules in a profile.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
end mySetup

on mySnippet()
	--![List preflight rules.]
	tell application "Adobe InDesign 2024"
		-- Assume the [Basic] profile exists.
		set myProfile to item 1 of preflight profiles
		set myRules to preflight profile rules of myProfile
		set ruleCount to count of myRules
		set str to "Preflight rules of " & name of myProfile & ": "
		repeat with i from 1 to ruleCount
			if i > 1 then
				set str to str & ", "
			end if
			set str to str & name of item i of myRules
		end repeat
		display alert str
	end tell
	--![List preflight rules.]
end mySnippet

on myTeardown()
end myTeardown
