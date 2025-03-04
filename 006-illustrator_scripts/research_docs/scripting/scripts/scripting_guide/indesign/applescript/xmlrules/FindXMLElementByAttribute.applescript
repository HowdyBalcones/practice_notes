--FindXMLElementByAttribute.applescript
--An InDesign AppleScript
--
--Finds an XML element by the contents of an attribute.
global myGlueCode
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	--![Find XML element by attribute.]
	tell application "Adobe InDesign 2024"
		set myDocument to active document
		set myPage to active page of active window
		set myFilePath to file path as string
		set myFilePath to myFilePath & "Scripts:Xml rules:glue code.scpt"
		tell myDocument
			set myRootXML to first XML element
			set myColorA to make color with properties {name:"ColorA", model:process, color value:{0, 100, 80, 0}}
		end tell
	end tell
	set myGlueCode to load script file myFilePath
	set myRuleSet to {my AddAttribute()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	set myRuleSet to {my FindAttribute()}
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	--![Find XML element by attribute.]
end mySnippet
on myTeardown()
end myTeardown
--![Find XML element by attribute - functions.]
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
on FindAttribute()
	script FindAttribute
		property name : "FindAttribute"
		property xpath : "/devices/device[@part_number = 'DS001']"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						set fill color of text 1 to "ColorA"
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return false
		end apply
	end script
end FindAttribute
--![Find XML element by attribute - functions.]
