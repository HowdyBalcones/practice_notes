--FindXMLElementByFindGrep.applescript
--An InDesign AppleScript
--
--Finds an XML element using find text.
global myGlueCode
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set mySetupScriptFile to my myFindFile("XMLRuleExampleSetup.appleScript", "Locate the file XMLRuleExampleSetup.appleScript")
		do script mySetupScriptFile
	end tell
end mySetup
on mySnippet()
	--![Find XML element by findGrep.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		tell myDocument
			set myRootXML to first XML element
			set myColorA to make color with properties {name:"ColorA", model:process, color value:{0, 100, 80, 0}}
		end tell
	end tell
	set myGlueCode to load script file myFilePath
	set myRuleSet to {my FindByFindGrep()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Find XML element by findGrep.]
end mySnippet
on myTeardown()
end myTeardown
--![Find XML element by findGrep - functions.]
on FindByFindGrep()
	script FindByFindGrep
		property name : "FindByFindGrep"
		property xpath : "/devices/device/description"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set find grep preferences to nothing
				set change grep preferences to nothing
				--Find all of the devices the mention both "pulse" and
				--"triangle" in their description.
				set find what of find grep preferences to "(?i)pulse.*?triangle|triangle.*?pulse"
				try
					tell myXMLElement
						set myFoundItems to find grep
						if (count myFoundItems) is greater than 0 then
							set fill color of text 1 to "ColorA"
						end if
					end tell
				on error myError
					set myReturnString to myError
				end try
				set find grep preferences to nothing
				set change grep preferences to nothing
			end tell
			return false
		end apply
	end script
end FindByFindGrep
--![Find XML element by findGrep - functions.]
on myFindFile(myFindFileName, myString)
	tell application "Adobe InDesign 2024"
		try
			set myScript to active script
		on error
			set myScript to path to me
		end try
	end tell
	tell application "Finder"
		set myScript to file myScript
		set myParentFolder to (container of myScript) as string
		set myFileName to myParentFolder & myFindFileName
		set myResult to exists myFileName
		if myResult is true then
		else
			set myFileName to choose file with prompt myString
		end if
	end tell
	return myFileName
end myFindFile
