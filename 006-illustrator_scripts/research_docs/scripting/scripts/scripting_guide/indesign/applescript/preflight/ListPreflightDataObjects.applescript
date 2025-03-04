--ListPreflightDataObjects.applescript
--An InDesign AppleScript
--
--Shows how to list all preflight data object under a rule in a profile.

main()

on main()
	mySetup()
	mySnippet()
	myTeardown()
end main

on mySetup()
end mySetup

on mySnippet()
	--![List preflight data objects.]
	tell application "Adobe InDesign 2024"
		set myProfile to item 1 of preflight profiles
		set myRule to item 1 of preflight profile rules of myProfile
		set dataObjects to rule data objects of myRule
		set dataObjectCount to count of dataObjects
		set str to "Preflight rule data objects of " & name of myProfile & "." & name of myRule & ": "
		repeat with i from 1 to dataObjectCount
			if i > 1 then
				set str to str & "; "
			end if
			set myObject to item i of dataObjects
			set str to str & name of myObject & ", "
			set str to str & data type of myObject & ", "
			set str to str & data value of myObject
		end repeat
		display alert str
	end tell
	--![List preflight data objects.]
end mySnippet

on myTeardown()
end myTeardown

