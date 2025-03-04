--ExtractSubset.applescript
--An InDesign AppleScript
--
--Extracts a subset of XML elements to a new XML element.
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
    --![Extract subset.]
    tell application "Adobe InDesign 2024"
    	set myDocument to active document
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		tell myDocument
			set myRootXML to first XML element
			set myXMLTag to make XML tag with properties {name:"VCOs"}
			tell myRootXML
				set myXMLElement to make XML element with properties {markup tag:myXMLTag}
			end tell
		end tell
	end tell
	set myGlueCode to load script file myFilePath
	set myRuleSet to {my ExtractVCO()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
    --![Extract subset.]
end mySnippet
on myTeardown()
end myTeardown
--![Extract subset - functions.]
on ExtractVCO()
	script ExtractVCO
		property name : "ExtractVCO"
		property xpath : "/devices/device/type"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					if contents of text 1 of myXMLElement is "VCO" then
						set myNewXMLElement to duplicate parent of myXMLElement
					end if
					move myNewXMLElement to end of XML element -1 of XML element 1 of document 1
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ExtractVCO
--![Extract subset - functions.]
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
