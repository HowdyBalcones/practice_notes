--Autocorrect.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Shows how to work with the autocorrect feature.
--
--The autocorrect preferences object turns the 
--autocorrect feature on or off.
tell application "Adobe InCopy 2024"
	tell auto correct preferences
		set autocorrect to true
		set auto correct capitalization errors to true
		--Add a word pair to the autocorrect list. Each auto correct table
		--is linked to a specific language. 
	end tell
	set myAutoCorrectTable to auto correct table "English: USA"
	--To safely add a word pair to the auto correct table, get the current
	--word pair list, then add the new word pair to that array, and then
	--set the autocorrect word pair list to the array.
	set myWordPairList to auto correct word pair list of myAutoCorrectTable
	--Add a new word pair to the array.
	set myWordPairList to myWordPairList & {{"paragarph", "paragraph"}}
	--Update the word pair list.
	set auto correct word pair list of auto correct table "English: USA" to myWordPairList
	--To clear all autocorrect word pairs in the current dictionary:
	--myAutoCorrectTable.autoCorrectWordPairList to {{}}
end tell

