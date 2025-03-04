--ProcessType.applescript
--An InDesign AppleScript
--
--Provide example fragmant for XMLRulesLayout script.
--<fragment>
to ProcessType()
	script ProcessType
		property name : "ProcessType"
		property xpath : "/devices/device/type"
		on apply(myXMLElement, myRuleProcessor)
			global myReturnString
			set myReturnString to "OK"
			tell application "Adobe InDesign 2024"
				set myDocument to document 1
				tell myDocument
					try
						tell myXMLElement
							insert text as content using "Circuit Type: " position before element
							insert text as content using return position after element
							apply paragraph style using "DeviceType"
						end tell
						set myPage to page -1 of myDocument
						set myBounds to my myGetBounds(myDocument, myPage)
						set myX1 to item 2 of myBounds
						set myY1 to (item 1 of myBounds) - 24
						set myX2 to myX1 + 48
						set myY2 to item 1 of myBounds
						set myTextFrame to place into frame myXMLElement on myPage geometric bounds {myY1, myX1, myY2, myX2}
						set fill color of myTextFrame to "Red"
						tell text frame preferences of myTextFrame
							set inset spacing to {6, 6, 6, 6}
						end tell
					on error myError
						set myReturnString to myError
					end try
				end tell
			end tell
			return true
		end apply
	end script
end ProcessType
--</fragment>
