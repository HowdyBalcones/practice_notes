--AddAttribute.applescript
--An InDesign AppleScript
--
--Adds an XML attribute to an XML element using an XML rule.
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
	--![Add attribute.]
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myRootXML to XML element 1 of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		set myRuleSet to {my AddAttribute()}
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Add attribute.]
end mySnippet
on myTeardown()
end myTeardown
--![Add attribute - functions.]
on AddAttribute()
	script AddAttribute
		property name : "AddAttribute"
		property xpath : "/devices/device/part_number"
		--Adds the content of an XML element to an attribute of
		--the parent of the XML element. This can make finding the
		--element by its contnet much easier and faster.
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						set myString to contents of text 1
						tell parent
							make XML attribute with properties {name:"part_number", value:myString}
						end tell
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end AddAttribute
--![Add attribute - functions.]
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
