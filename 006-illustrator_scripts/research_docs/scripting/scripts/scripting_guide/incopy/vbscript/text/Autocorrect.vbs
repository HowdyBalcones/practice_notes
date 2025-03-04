Rem Autocorrect.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to work with the autocorrect feature.
Rem
Rem The autocorrect preferences object turns the
Rem autocorrect feature on or off.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	ReDim myNewWordPairList(0)
	Rem Add a word pair to the autocorrect list. Each 
	Rem AutoCorrectTable is linked to a specific language.
	Set myAutoCorrectTable = myInCopy.AutoCorrectTables.Item("English: USA")
	Rem To safely add a word pair to the auto correct table, get the current
	Rem word pair list, then add the new word pair to that array, and then
	Rem set the autocorrect word pair list to the array.
	myWordPairList = myAutoCorrectTable.AutoCorrectWordPairList
	ReDim myNewWordPairList(UBound(myWordPairList))
	For myCounter = 0 To UBound(myWordPairList) - 1
		myNewWordPairList(myCounter) = myWordPairList(myCounter)
	Next
	Rem Add a new word pair to the array.
	myNewWordPairList(UBound(myNewWordPairList)) = (Array("paragarph", "paragraph"))
	Rem Update the word pair list.
	myAutoCorrectTable.AutoCorrectWordPairList = myNewWordPairList
	Rem To clear all autocorrect word pairs in the current dictionary:
	Rem myAutoCorrectTable.autoCorrectWordPairList = array(())
	Rem Turn autocorrect on if it's not on already.
	If myInCopy.AutoCorrectPreferences.AutoCorrect = False Then
		myInCopy.AutoCorrectPreferences.AutoCorrect = True
	End If
	myInCopy.AutoCorrectPreferences.AutoCorrectCapitalizationErrors = True
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function