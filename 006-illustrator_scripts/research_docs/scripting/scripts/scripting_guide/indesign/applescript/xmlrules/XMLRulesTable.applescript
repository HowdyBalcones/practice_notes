--XMLRulesTable.applescript
--An InDesign AppleScript
--
--Shows how to create a table from XML elements using XML rules.
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
		set myRuleSet to {my AddAttribute()}
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	tell application "Adobe InDesign 2024"
		tell myDocument
			try
				tell text frame 1 of myPage to delete
			end try
			try
				set myRowTag to XML tag "Row"
			on error
				set myRowTag to make XML tag with properties {name:"Row"}
			end try
			try
				set myColumnTag to XML tag "Column"
			on error
				set myColumnTag to make XML tag with properties {name:"Column"}
			end try
			try
				set myMarkupTag to XML tag "VCOs"
			on error
				set myMarkupTag to make XML tag with properties {name:"VCOs"}
			end try
			--Create a container element for the VCO elements.
			tell myRootXML
				set myVCOElement to make XML element with properties {markup tag:myMarkupTag}
			end tell
			--myVCOElement will contain the VCO elements we'll move to the table.
			tell myVCOElement
				set myContainerElement to make XML element with properties {markup tag:myMarkupTag}
			end tell
			tell myContainerElement
				--Create an XML element for the header row in the table.
				tell (make XML element with properties {markup tag:"Row"})
					--Populate the row with cells.
					make XML element with properties {markup tag:myColumnTag, contents:"Name:"}
					make XML element with properties {markup tag:myColumnTag, contents:"Part Number:"}
					make XML element with properties {markup tag:myColumnTag, contents:"Power:"}
					make XML element with properties {markup tag:myColumnTag, contents:"Package:"}
					make XML element with properties {markup tag:myColumnTag, contents:"Price:"}
					make XML element with properties {markup tag:myColumnTag, contents:"Description:"}
				end tell
			end tell
			set myRuleSet to {my ProcessDevice(), my ProcessName(), my ProcessPartNumber(), my ProcessPackageOne(), my ProcessPackage(), my ProcessMaximumVoltage(), my ProcessSupplyVoltage(), my ProcessPrice(), my ProcessDescription()}
		end tell
	end tell
	tell myGlueCode
		__processRuleSet(myRootXML, myRuleSet, {})
	end tell
	tell application "Adobe InDesign 2024"
		--![XML rules table.]
		tell myContainerElement
			set myTable to convert element to table row tag myRowTag cell tag myColumnTag
		end tell
		--![XML rules table.]
		set myBounds to my myGetBounds(myDocument, myPage)
		set width of myTable to (item 4 of myBounds) - (item 2 of myBounds)
		tell myVCOElement
			place into frame on myPage geometric bounds myBounds
		end tell
		tell myTable
			set myHeaderRow to make row at beginning
		end tell
		tell cell 1 of myHeaderRow to merge with cell -1 of myHeaderRow
		set contents of cell 1 of myHeaderRow to "Voltage Controlled Oscillators"
		set justification of text 1 of cell 1 of myHeaderRow to center align
		set row type of myHeaderRow to header row
		set row type of row 2 of myTable to header row
	end tell
	--</fragment>
end mySnippet
on myTeardown()
end myTeardown
on AddAttribute()
	script AddAttribute
		property name : "AddAttribute"
		property xpath : "/devices/device/type"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						set myString to contents of text 1
						tell parent
							set myName to "type"
							make XML attribute with properties {name:myName, value:myString}
						end tell
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return false
		end apply
	end script
end AddAttribute
--![XML rules table - processDevice.]
on ProcessDevice()
	script ProcessDevice
		property name : "ProcessDevice"
		property xpath : "//device[@type = 'VCO']"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						set myContainerElement to XML element -1 of XML element -1 of XML element 1
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Row"}
						end tell
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return false
		end apply
	end script
end ProcessDevice
--![XML rules table - processDevice.]
on ProcessName()
	script ProcessName
		property name : "ProcessName"
		property xpath : "//device[@type = 'VCO']/name"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						--/devices/VCOs/VCOs/Row
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						move myXMLElement to beginning of myNewElement
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessName
on ProcessPartNumber()
	script ProcessPartNumber
		property name : "ProcessPartNumber"
		property xpath : "//device[@type = 'VCO']/part_number"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						--/devices/VCOs/VCOs/Row
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						move myXMLElement to beginning of myNewElement
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessPartNumber
on ProcessMaximumVoltage()
	script ProcessMaximumVoltage
		property name : "ProcessMaximumVoltage"
		property xpath : "//device[@type = 'VCO']/supply_voltage/maximum"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				try
					tell myXMLElement
						insert text as content using " to " position before element
						insert text as content using " volts" position after element
					end tell
				on error myError
					set myReturnString to myError
				end try
			end tell
			return true
		end apply
	end script
end ProcessMaximumVoltage
on ProcessSupplyVoltage()
	script ProcessSupplyVoltage
		property name : "ProcessSupplyVoltage"
		property xpath : "//device[@type = 'VCO']/supply_voltage"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__processChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						--/devices/VCOs/VCOs/Row
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						move myXMLElement to beginning of myNewElement
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessSupplyVoltage
on ProcessPackageOne()
	script ProcessPackageOne
		property name : "ProcessPackageOne"
		property xpath : "//device[@type = 'VCO']/package[1]"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						move myXMLElement to beginning of myNewElement
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessPackageOne
on ProcessPackage()
	script ProcessPackage
		property name : "ProcessPackage"
		property xpath : "//device[@type = 'VCO']/package"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myPackageElement to XML element -1 of myTable
						set myContainerElement to XML element -1 of myPackageElement
						set myXMLElement to move myXMLElement to end of myContainerElement
						tell myXMLElement
							insert text as content using return position before element
						end tell
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessPackage
--![XML rules table - processPrice.]
on ProcessPrice()
	script ProcessPrice
		property name : "ProcessPrice"
		property xpath : "//device[@type = 'VCO']/price"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						--/devices/VCOs/VCOs/Row
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						set myXMLElement to move myXMLElement to beginning of myNewElement
						tell myXMLElement
							insert text as content using "$" position before element
						end tell
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessPrice
--![XML rules table - processPrice.]
on ProcessDescription()
	script ProcessDescription
		property name : "ProcessDescription"
		property xpath : "//device[@type = 'VCO']/description"
		on apply(myXMLElement, myRuleProcessor)
			tell myGlueCode
				__skipChildren(myRuleProcessor)
			end tell
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						set myRootElement to XML element 1
						set myVCOs to XML element -1 of myRootElement
						set myTable to XML element -1 of myVCOs
						set myContainerElement to XML element -1 of myTable
						tell myContainerElement
							set myNewElement to make XML element with properties {markup tag:"Column"}
						end tell
						move myXMLElement to beginning of myNewElement
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessDescription
on myGetBounds(myDocument, myPage)
	tell application "Adobe InDesign 2024"
		tell document preferences of myDocument
			set myPageWidth to page width
			set myPageHeight to page height
		end tell
		tell margin preferences of myPage
			if side of myPage is left hand then
				set myX2 to right
				set myX1 to left
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
