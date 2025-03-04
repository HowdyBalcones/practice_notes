--ScriptLabels.applescript
--An InDesign AppleScript
--
--Shows how to set script labels and how to
--get references to page items by label.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	--![Working with Script Labels.]
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set myPage to page 1 of myDocument
		set myPageWidth to page width of document preferences of myDocument
		set myPageHeight to page height of document preferences of myDocument
		--Create 10 random page items.
		repeat with i from 1 to 10
			set myX1 to my myGetRandom(0, myPageWidth, false)
			set myY1 to my myGetRandom(0, myPageHeight, false)
			set myX2 to my myGetRandom(0, myPageWidth, false)
			set myY2 to my myGetRandom(0, myPageHeight, false)
			tell myPage
				set myRectangle to make rectangle �
					with properties {geometric bounds:{myY1, myX1, myY2, myX2}}
			end tell
			if my myGetRandom(0, 1, true) = 1 then
				set label of myRectangle to "myScriptLabel"
			end if
		end repeat
		set myCount to 0
		repeat with i from 1 to count of page items of myPage
			if label of page item i of myPage is "myScriptLabel" then
				set myCount to myCount + 1
			end if
		end repeat
		display dialog ("Found " & myCount & " page items with the label.")
	end tell
	--![Working with Script Labels.]
end mySnippet
on myTeardown()
end myTeardown
--![Working with Script Labels - GetRandom.]
--This function gets a random number in the range myStart to myEnd.
on myGetRandom(myStart, myEnd, myInteger)
	set myRange to myEnd - myStart
	if myInteger = true then
		set myRandom to myStart + (random number from myStart to myEnd)
	else
		set myRandom to myStart + (random number from myStart to myEnd) as integer
	end if
	return myRandom
end myGetRandom
--![Working with Script Labels - GetRandom.]

