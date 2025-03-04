--SplitStory.applescript
--An InDesign AppleScript
--
--Splits the selected story into separate (i.e., unthreaded) text frames.
--To use this script, select a text frame, then run the script.
--
--Note: Any overset text at the end of the story will be deleted.
--Note: Hyphenation points between text frames will not be retained.
--
--For more on InDesign/InCopy scripting see the documentation included in the Scripting SDK 
--available at http://www.adobe.com/devnet/indesign/sdk.html
--or visit the InDesign Scripting User to User forum at http://www.adobeforums.com
--
tell application "Adobe InDesign 2024"
	set myTextObjects to {insertion point, character, word, line, text style range, text, paragraph, text column}
	set mySelection to selection
	if (count mySelection) > 0 then
		if class of item 1 of mySelection is in myTextObjects then
			--Use the parent story of the first insertion point; selections can span multiple text frames.
			set myStory to parent story of item 1 of mySelection
			set mySplitStory to true
		else if class of item 1 of mySelection is text frame then
			set myStory to parent story of item 1 of mySelection
			set mySplitStory to true
		else
			set mySplitStory to false
		end if
		if mySplitStory is true then
			duplicate text containers of myStory
			delete text containers of myStory
		end if
	end if
end tell
