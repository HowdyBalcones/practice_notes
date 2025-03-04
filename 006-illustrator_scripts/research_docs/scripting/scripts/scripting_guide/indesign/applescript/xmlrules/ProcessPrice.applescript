--ProcessPrice.applescript
--An InDesign AppleScript
--
--Provide example fragmant for XMLRulesTable script.
--<fragment>
to ProcessPrice()
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
--</fragment>
