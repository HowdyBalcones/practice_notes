--ReturningFalse.applescript
--An InDesign AppleScript
--
--Demonstrates the effect of returning false vs. returning true
--from the apply function of an XML rule.
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
	--![Returning false.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myPage to active page of active window
		set myRootXML to first XML element of document 1
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my ReturnFalse(), my ReturnTrue()}
		set myDocument to document 1
		tell myDocument
			set myColorA to make color with properties {name:"ColorA", model:process, color value:{0, 100, 80, 0}}
			set myColorB to make color with properties {name:"ColorB", model:process, color value:{100, 0, 80, 0}}
		end tell
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Returning false.]
end mySnippet
on myTeardown()
end myTeardown
--![Returning false - functions.]
on ReturnTrue()
	script ReturnTrue
		property name : "ReturnTrue"
		property xpath : "//*"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						if myCounter mod 2 = 0 then
							set fill color of text 1 to "ColorA"
						end if
						set myCounter to myCounter + 1
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			--Do not process the element with any further matching rules.
			return true
		end apply
	end script
end ReturnTrue
on ReturnFalse()
	script ReturnFalse
		property name : "ReturnFalse"
		property xpath : "//*"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						set fill color of text 1 to "ColorB"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			--Leave the XML element available for further matching rules.
			return false
		end apply
	end script
end ReturnFalse
--![Returning false - functions.]
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
