--ConvertToAttribute.applescript
--An InDesign AppleScript
--
--Converts an XML element to an XML attribute.
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
	--![Convert to attribute.]
	tell application "Adobe InDesign 2024"
		set myRootXML to first XML element of active document
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my ConvertToAttribute()}
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Convert to attribute - functions.]
end mySnippet
on myTeardown()
end myTeardown
--![Convert to attribute.]
on ConvertToAttribute()
	script ConvertToAttribute
		property name : "ConvertToAttribute"
		property xpath : "/devices/device/part_number"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						convert to attribute ("PartNumber")
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ConvertToAttribute
--![Convert to attribute - functions.]
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
