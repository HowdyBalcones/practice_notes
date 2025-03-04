--ConditionalText.applescripttell application "Adobe InDesign 2024"tell application "Adobe InDesign 2024"tell application "Adobe InDesign 2024"
--An Adobe InDesign AppleScript
--
--Shows how to create conditional text.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell page 1 of myDocument
			set myTextFrame to make text frame with properties {geometric bounds:my myGetBounds(myDocument, page 1 of myDocument)}
		end tell
		set myStory to parent story of myTextFrame
		set contents of myStory to "This following paragraphs are examples of conditional text:
Applescript
JavaScript
VBScript
"
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myStory to story 1 of myDocument
		--<fragment>
		tell myDocument
			set myAppleScriptCondition to make condition with properties {name:"AppleScript", indicator color:red, visible:true, indicator method:use highlight}
			tell paragraph 2 of myStory to apply conditions using myAppleScriptCondition
			set myJavaScriptCondition to make condition with properties {name:"JavaScript", indicator color:blue, visible:true, indicator method:use highlight}
			tell paragraph 3 of myStory to apply conditions using myJavaScriptCondition
			set myVBScriptCondition to make condition with properties {name:"VBScript", indicator color:green, visible:true, indicator method:use highlight}
			tell paragraph 4 of myStory to apply conditions using myVBScriptCondition
			set myMacOSConditionSet to make condition set with properties {name:"MacOSCondition", set conditions:{{myAppleScriptCondition, true}, {myJavaScriptCondition, true}, {myVBScriptCondition, false}}}
			set myWindowsConditionSet to make condition set with properties {name:"WindowsCondition", set conditions:{{myAppleScriptCondition, false}, {myJavaScriptCondition, true}, {myVBScriptCondition, true}}}
			set active condition set of conditional text preferences to myMacOSConditionSet
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
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
