--SampleXMLRule.applescript
--An InDesign AppleScript
--
--A Sample XML Rule
--![Sample XML rule.]
on RuleName()
	script RuleName
		property name : "RuleNameAsString"
		property xpath : "ValidXPathSpecifier"
		on apply(element, ruleSet, ruleProcessor)
			--Do something here.
			--Return true to stop further processing of the XML element.
			return false
		end apply
	end script
end RuleName
--![Sample XML rule.]
