--ProcessChildren.applescript
--An InDesign AppleScript
--
--Shows the difference between a rule that
--returns false and a rule that returns true.
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
	--<fragment>
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myPage to active page of active window
		set myRootXML to first XML element of myDocument
		set myApplicationPath to file path
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		set myGlueCode to load script file myFilePath
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, myPage)}
		end tell
		set myRuleSet to {my NormalRule(), my ProcessChildrenRule()}
	end tell
	tell myGlueCode
		--The third parameter of __processRuleSet is a
		--prefix mapping table; we'll leave it empty.
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--</fragment>
end mySnippet
on myTeardown()
end myTeardown
--![Process children.]
to NormalRule()
	script NormalRule
		property name : "NormalRule"
		property xpath : "//XMLElement"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell insertion point -1 of story 1 of document 1
						set contents to value of XML attribute 1 of myXMLElement & return
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return false
		end apply
	end script
end NormalRule
to ProcessChildrenRule()
	script ProcessChildrenRule
		property name : "ProcessChildrenRule"
		property xpath : "//XMLElement"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__processChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell insertion point -1 of story 1 of document 1
						set contents to value of XML attribute 1 of myXMLElement & return
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return false
		end apply
	end script
end ProcessChildrenRule
--![Process children.]
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to left
				set myX1 to right
			else
				set myX1 to left
				set myX2 to right
			end if
			set myY1 to top
			set myY2 to bottom
		end tell
		set myX2 to myPageWidth - myX2
		set myY2 to myPageHeight - myY2
		return {myY1, myX1, myY2, myX2}
	end tell
end myGetBounds
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
